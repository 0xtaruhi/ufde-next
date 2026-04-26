import { useState, useEffect, useContext } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Container,
  Card,
  Stack,
  Title,
  Text,
  TextInput,
  Button,
  Group,
  Select,
  Alert,
} from '@mantine/core';
import { TbFolder, TbFile, TbCircuitGround, TbInfoCircle, TbPlayerPlay, TbBooks } from 'react-icons/tb';
import { open } from '@tauri-apps/plugin-dialog';
import { notifications } from '@mantine/notifications';
import {
  showFailedNotification,
  update2SuccessNotification,
  update2FailedNotification,
} from './Notifies';
import { readDir } from '@tauri-apps/plugin-fs';
import { dirname, join, basename, resolveResource } from '@tauri-apps/api/path';
import { invoke } from '@tauri-apps/api/core';
import { ProjectContext } from '../App';
import { getAllPorts } from '../utils/VerilogParser';

const SIM_FILE_SUFFIXES = ['_gate.v', '_map.v', '_pack.v', '_route.v'];

function VerificationPage() {
  const { t } = useTranslation();
  const projectContext = useContext(ProjectContext);
  const { project, setProject, setProjectModified } = projectContext;

  const [modelsimPath, setModelsimPath] = useState<string>('');
  const [testbenchPath, setTestbenchPath] = useState<string>('');
  const [customSimlibPath, setCustomSimlibPath] = useState<string>('');
  const [customTopModule, setCustomTopModule] = useState<string>('');
  const [simOptions, setSimOptions] = useState<{ value: string; label: string }[]>([]);
  const [selectedSimFile, setSelectedSimFile] = useState<string | null>(null);
  const [isSimulating, setIsSimulating] = useState<boolean>(false);

  useEffect(() => {
    if (project) {
      const verif = project.settings.verification;
      setModelsimPath(verif?.modelsimDir ?? '');
      setTestbenchPath(verif?.testbenchPath ?? '');
      setCustomSimlibPath(verif?.customSimlibPath ?? '');
      setCustomTopModule(verif?.topModule ?? '');
    } else {
      setModelsimPath('');
      setTestbenchPath('');
      setCustomSimlibPath('');
      setCustomTopModule('');
    }
  }, [project?.path]);

  useEffect(() => {
    const scanSimFiles = async () => {
      if (!project?.path) {
        setSimOptions([]);
        setSelectedSimFile(null);
        return;
      }
      try {
        const projectDir = await dirname(project.path);
        const entries = await readDir(projectDir);
        const files = entries
          .filter((entry) => entry.isFile)
          .map((entry) => entry.name)
          .filter((name) =>
            SIM_FILE_SUFFIXES.some((suffix) => name.endsWith(suffix))
          )
          .sort();
        setSimOptions(files.map((name) => ({ value: name, label: name })));
        if (files.length > 0) {
          setSelectedSimFile(files[0]);
        } else {
          setSelectedSimFile(null);
        }
      } catch (e) {
        setSimOptions([]);
        setSelectedSimFile(null);
      }
    };
    scanSimFiles();
  }, [project?.path]);

  const updateVerificationSetting = (key: 'modelsimDir' | 'testbenchPath' | 'customSimlibPath' | 'topModule', value: string) => {
    if (!project) return;
    const newProject = { ...project };
    if (!newProject.settings.verification) {
      newProject.settings.verification = { modelsimDir: '', testbenchPath: '', customSimlibPath: '' };
    }
    newProject.settings.verification[key] = value;
    setProject(newProject);
    setProjectModified(true);
  };

  const handleSelectModelsimDir = async () => {
    try {
      const selected = await open({
        directory: true,
        multiple: false,
        title: t('verification.selectModelsimTitle'),
      });
      if (selected) {
        const path = selected as string;
        setModelsimPath(path);
        updateVerificationSetting('modelsimDir', path);
      }
    } catch (err) {
      showFailedNotification({
        title: t('verification.error'),
        message: t('verification.selectModelsimFailed', { error: err }),
      });
    }
  };

  const handleSelectTestbench = async () => {
    try {
      const selected = await open({
        multiple: false,
        directory: false,
        title: t('verification.selectTestbenchTitle'),
        filters: [
          { name: 'Verilog/SystemVerilog', extensions: ['v', 'sv', 'vt'] },
          { name: 'All Files', extensions: ['*'] },
        ],
      });
      if (selected) {
        const path = selected as string;
        setTestbenchPath(path);
        updateVerificationSetting('testbenchPath', path);

        // Auto-detect top module from testbench
        try {
          const ports = await getAllPorts(path);
          const modules = Array.from(ports.keys());
          if (modules.length > 0) {
            const detected = modules[modules.length - 1];
            setCustomTopModule(detected);
            updateVerificationSetting('topModule', detected);
          }
        } catch (e) {
          // Silently fallback to empty; user can manually enter
        }
      }
    } catch (err) {
      showFailedNotification({
        title: t('verification.error'),
        message: t('verification.selectTestbenchFailed', { error: err }),
      });
    }
  };

  const handleSelectCustomSimlib = async () => {
    try {
      const selected = await open({
        multiple: false,
        directory: false,
        title: t('verification.selectCustomSimlibTitle'),
        filters: [
          { name: 'Verilog', extensions: ['v'] },
          { name: 'All Files', extensions: ['*'] },
        ],
      });
      if (selected) {
        const path = selected as string;
        setCustomSimlibPath(path);
        updateVerificationSetting('customSimlibPath', path);
      }
    } catch (err) {
      showFailedNotification({
        title: t('verification.error'),
        message: t('verification.selectCustomSimlibFailed', { error: err }),
      });
    }
  };

  const handleClearCustomSimlib = () => {
    setCustomSimlibPath('');
    updateVerificationSetting('customSimlibPath', '');
  };

  const handleReset = () => {
    setModelsimPath('');
    setTestbenchPath('');
    setCustomSimlibPath('');
    setCustomTopModule('');
    if (simOptions.length > 0) {
      setSelectedSimFile(simOptions[0].value);
    } else {
      setSelectedSimFile(null);
    }
    updateVerificationSetting('modelsimDir', '');
    updateVerificationSetting('testbenchPath', '');
    updateVerificationSetting('customSimlibPath', '');
    updateVerificationSetting('topModule', '');
  };

  const handleSimulate = async () => {
    if (!project || !selectedSimFile || !modelsimPath || !testbenchPath) return;

    setIsSimulating(true);
    const projectDir = await dirname(project.path);
    const simNetlistPath = await join(projectDir, selectedSimFile);

    let topModule = customTopModule.trim();
    if (!topModule) {
      try {
        const ports = await getAllPorts(testbenchPath);
        const modules = Array.from(ports.keys());
        if (modules.length > 0) {
          topModule = modules[modules.length - 1];
        } else {
          const tbName = await basename(testbenchPath);
          topModule = tbName.replace(/\.(v|sv|vt)$/i, '');
        }
      } catch (e) {
        const tbName = await basename(testbenchPath);
        topModule = tbName.replace(/\.(v|sv|vt)$/i, '');
      }
    }

    const notifyId = notifications.show({
      title: t('verification.runningTitle'),
      message: t('verification.runningMessage'),
      autoClose: false,
      loading: true,
    });

    try {
      const edalibDir = await resolveResource('resource/edalib');
      const vcdFileName: string = await invoke('run_modelsim_simulation', {
        args: {
          projectDir,
          modelsimDir: modelsimPath,
          netlistPath: simNetlistPath,
          testbenchPath,
          topModule,
          edalibDir,
          customSimlibPath: customSimlibPath || null,
        },
      });

      update2SuccessNotification({
        id: notifyId,
        title: t('verification.successTitle'),
        message: t('verification.successMessage', { vcd: vcdFileName }),
      });
    } catch (err: any) {
      update2FailedNotification({
        id: notifyId,
        title: t('verification.errorTitle'),
        message: err.message || String(err),
      });
    } finally {
      setIsSimulating(false);
    }
  };

  const canRun = !!project && !!selectedSimFile && !!modelsimPath && !!testbenchPath;

  return (
    <Container fluid p="md" h="100%">
      <Title order={2} mb="md">{t('verification.title')}</Title>
      <Text c="dimmed" mb="lg">{t('verification.subtitle')}</Text>

      <Stack gap="md" h="calc(100% - 80px)">
        <Card shadow="sm" withBorder>
          <Stack gap="md">
            {/* Simulation netlist selection */}
            <Card withBorder padding="sm">
              <Stack gap="xs">
                {!project && (
                  <Alert icon={<TbInfoCircle size={16} />} color="orange" variant="light" p="xs">
                    {t('verification.noProjectOpen')}
                  </Alert>
                )}
                <Group align="flex-end">
                  <Select
                    label={t('verification.simNetlist')}
                    placeholder={t('verification.noNetlistPlaceholder')}
                    data={simOptions}
                    value={selectedSimFile}
                    onChange={setSelectedSimFile}
                    disabled={simOptions.length === 0}
                    style={{ flex: 1 }}
                    size="sm"
                    leftSection={<TbCircuitGround size={16} />}
                  />
                </Group>
                {simOptions.length === 0 && project && (
                  <Text size="xs" c="dimmed">
                    {t('verification.noNetlistFound')}
                  </Text>
                )}
              </Stack>
            </Card>

            {/* ModelSim bin directory */}
            <Card withBorder padding="sm">
              <Stack gap="xs">
                <Group align="flex-end">
                  <TextInput
                    label={t('verification.modelsimPath')}
                    value={modelsimPath}
                    readOnly
                    placeholder={t('verification.noDirPlaceholder')}
                    style={{ flex: 1 }}
                    size="sm"
                  />
                  <Button
                    leftSection={<TbFolder size={16} />}
                    onClick={handleSelectModelsimDir}
                    variant="light"
                    size="sm"
                  >
                    {t('verification.selectModelsimButton')}
                  </Button>
                </Group>
                <Text size="xs" c="dimmed">
                  {t('verification.modelsimPathHelp')}
                </Text>
              </Stack>
            </Card>

            {/* Testbench file */}
            <Card withBorder padding="sm">
              <Stack gap="xs">
                <Group align="flex-end">
                  <TextInput
                    label={t('verification.testbenchPath')}
                    value={testbenchPath}
                    readOnly
                    placeholder={t('verification.noFilePlaceholder')}
                    style={{ flex: 1 }}
                    size="sm"
                  />
                  <Button
                    leftSection={<TbFile size={16} />}
                    onClick={handleSelectTestbench}
                    variant="light"
                    size="sm"
                  >
                    {t('verification.selectTestbenchButton')}
                  </Button>
                </Group>
                <TextInput
                  label={t('verification.topModule')}
                  value={customTopModule}
                  onChange={(e) => {
                    setCustomTopModule(e.currentTarget.value);
                    updateVerificationSetting('topModule', e.currentTarget.value);
                  }}
                  placeholder={t('verification.topModulePlaceholder')}
                  size="sm"
                />
              </Stack>
            </Card>

            {/* Custom Simulation Library (Optional) */}
            <Card withBorder padding="sm">
              <Group align="flex-end">
                <TextInput
                  label={t('verification.customSimlibPath')}
                  value={customSimlibPath}
                  readOnly
                  placeholder={t('verification.noCustomSimlibPlaceholder')}
                  style={{ flex: 1 }}
                  size="sm"
                />
                <Button
                  leftSection={<TbBooks size={16} />}
                  onClick={handleSelectCustomSimlib}
                  variant="light"
                  size="sm"
                >
                  {t('verification.selectCustomSimlibButton')}
                </Button>
                {customSimlibPath && (
                  <Button
                    variant="subtle"
                    color="gray"
                    size="sm"
                    onClick={handleClearCustomSimlib}
                  >
                    {t('verification.clearButton')}
                  </Button>
                )}
              </Group>
            </Card>
          </Stack>
        </Card>

        <Group justify="flex-end" mt="sm">
          <Button variant="outline" onClick={handleReset} size="sm" disabled={isSimulating}>
            {t('verification.resetButton')}
          </Button>
          <Button
            leftSection={<TbPlayerPlay size={16} />}
            onClick={handleSimulate}
            loading={isSimulating}
            disabled={!canRun}
            size="sm"
            color="blue"
          >
            {isSimulating ? t('verification.runningButton') : t('verification.runButton')}
          </Button>
        </Group>
      </Stack>
    </Container>
  );
}

export default VerificationPage;
