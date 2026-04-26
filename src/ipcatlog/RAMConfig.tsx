import React, { useState, useEffect, useContext, useRef } from 'react';
import {
  Stack,
  Card,
  TextInput,
  Button,
  Title,
  Text,
  Group,
  Radio,
  Select,
  Tabs,
  Alert,
} from '@mantine/core';
import { TbUpload, TbPray, TbSettings, TbFile, TbInfoCircle, TbPhoto } from 'react-icons/tb';
import { open } from '@tauri-apps/plugin-dialog';
import { Command } from '@tauri-apps/plugin-shell';
import { BaseIPConfigProps } from './types';
import { exists, writeTextFile, mkdir, remove } from '@tauri-apps/plugin-fs';
import { notifications } from '@mantine/notifications';
import { update2SuccessNotification, update2FailedNotification } from '../pages/Notifies';
import { useTranslation } from 'react-i18next';
import { getDirOfFile } from '../utils/utils';
import { join, dirname } from '@tauri-apps/api/path';
import { ProjectContext } from '../App';

interface RAMConfigProps extends BaseIPConfigProps {}

type RamType = 'single' | 'dual';
type InputMode = 'file' | 'param' | 'image';

interface RamConfigOption {
  width: number;
  depth: number;
  label: string;
  value: string;
}

const RAM_CONFIG_OPTIONS: RamConfigOption[] = [
  { width: 1, depth: 4096, label: '1 x 4096', value: '1_4096' },
  { width: 2, depth: 2048, label: '2 x 2048', value: '2_2048' },
  { width: 4, depth: 1024, label: '4 x 1024', value: '4_1024' },
  { width: 8, depth: 512, label: '8 x 512', value: '8_512' },
  { width: 16, depth: 256, label: '16 x 256', value: '16_256' },
  { width: 2, depth: 4096, label: '2 x 4096', value: '2_4096' },
  { width: 4, depth: 2048, label: '4 x 2048', value: '4_2048' },
  { width: 8, depth: 1024, label: '8 x 1024', value: '8_1024' },
  { width: 16, depth: 512, label: '16 x 512', value: '16_512' },
  { width: 32, depth: 256, label: '32 x 256', value: '32_256' },
  { width: 4, depth: 4096, label: '4 x 4096', value: '4_4096' },
  { width: 8, depth: 2048, label: '8 x 2048', value: '8_2048' },
  { width: 16, depth: 1024, label: '16 x 1024', value: '16_1024' },
  { width: 32, depth: 512, label: '32 x 512', value: '32_512' },
  { width: 64, depth: 256, label: '64 x 256', value: '64_256' },
  { width: 8, depth: 4096, label: '8 x 4096', value: '8_4096' },
  { width: 16, depth: 2048, label: '16 x 2048', value: '16_2048' },
  { width: 32, depth: 1024, label: '32 x 1024', value: '32_1024' },
  { width: 64, depth: 512, label: '64 x 512', value: '64_512' },
  { width: 128, depth: 256, label: '128 x 256', value: '128_256' },
  { width: 16, depth: 4096, label: '16 x 4096', value: '16_4096' },
  { width: 32, depth: 2048, label: '32 x 2048', value: '32_2048' },
  { width: 64, depth: 1024, label: '64 x 1024', value: '64_1024' },
  { width: 128, depth: 512, label: '128 x 512', value: '128_512' },
  { width: 256, depth: 256, label: '256 x 256', value: '256_256' },
];

const getTotalBits = (configValue: string): number => {
  const config = RAM_CONFIG_OPTIONS.find(c => c.value === configValue);
  if (!config) return 0;
  return config.width * config.depth;
};

const formatBits = (bits: number): string => {
  if (bits >= 1024 * 1024) {
    return `${Math.floor(bits / 1024 / 1024)} Mb`;
  } else if (bits >= 1024) {
    return `${Math.floor(bits / 1024)} Kb`;
  }
  return `${bits} b`;
};

const RAMConfig: React.FC<RAMConfigProps> = ({ onConfigChange }) => {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);
  
  const [inputMode, setInputMode] = useState<InputMode>('file');
  const [mifFilePath, setMifFilePath] = useState<string>('');
  const [ramType, setRamType] = useState<RamType>('single');
  const [singleConfig, setSingleConfig] = useState<string>('8_512');
  const [portAConfig, setPortAConfig] = useState<string>('8_512');
  const [portBConfig, setPortBConfig] = useState<string>('16_256');
  const [, setGeneratedMifPath] = useState<string>('');
  const [successMifPath, setSuccessMifPath] = useState<string>('');
  const [successVPath, setSuccessVPath] = useState<string>('');
  const [isProcessing, setIsProcessing] = useState<boolean>(false);
  const [imageFilePath, setImageFilePath] = useState<string>('');
  const [imageMifPath, setImageMifPath] = useState<string>('');
  const [previewImagePath, setPreviewImagePath] = useState<string>('');

  const getCompatibleConfigs = (referenceValue: string): RamConfigOption[] => {
    const targetBits = getTotalBits(referenceValue);
    const refConfig = RAM_CONFIG_OPTIONS.find(c => c.value === referenceValue);
    const refWidth = refConfig?.width || 0;
    // Port B width must be >= Port A width (y >= x in RAMB4_Sx_Sy)
    return RAM_CONFIG_OPTIONS.filter(c => c.width * c.depth === targetBits && c.width >= refWidth);
  };

  const onConfigChangeRef = useRef(onConfigChange);
  onConfigChangeRef.current = onConfigChange;

  useEffect(() => {
    if (onConfigChangeRef.current) {
      onConfigChangeRef.current({ 
        mifPath: mifFilePath,
        inputMode,
        ramType,
        singleConfig,
        portAConfig,
        portBConfig,
      });
    }
  }, [mifFilePath, inputMode, ramType, singleConfig, portAConfig, portBConfig]);

  useEffect(() => {
    const compatibleConfigs = getCompatibleConfigs(portAConfig);
    const currentPortBValid = compatibleConfigs.some(c => c.value === portBConfig);
    if (!currentPortBValid && compatibleConfigs.length > 0) {
      setPortBConfig(compatibleConfigs[0].value);
    }
  }, [portAConfig]);

  useEffect(() => {
    setSuccessMifPath('');
    setSuccessVPath('');
  }, [inputMode, mifFilePath, ramType, singleConfig, portAConfig, portBConfig]);

  useEffect(() => {
    if (inputMode !== 'image') {
      setImageFilePath('');
      setImageMifPath('');
      setPreviewImagePath('');
    }
  }, [inputMode]);

  const handleSelectFile = async () => {
    try {
      const selected = await open({
        multiple: false,
        filters: [{ name: 'Memory Initialization Files', extensions: ['mif'] }],
        title: t('ram.selectFileTitle'),
        directory: false,
      });

      if (selected) {
        setMifFilePath(selected as string);
        setSuccessMifPath('');
        setSuccessVPath('');
      }
    } catch (err) {
      notifications.show({
        title: t('ram.error'),
        message: t('ram.selectFileFailed', { error: err }),
        color: 'red',
      });
    }
  };

  const handleSelectImage = async () => {
    try {
      const selected = await open({
        multiple: false,
        filters: [
          { name: 'Image Files', extensions: ['png', 'jpg', 'jpeg', 'bmp'] },
          { name: 'PNG', extensions: ['png'] },
          { name: 'JPEG', extensions: ['jpg', 'jpeg'] },
          { name: 'BMP', extensions: ['bmp'] },
        ],
        title: t('ram.selectImageTitle', 'Select Image File'),
        directory: false,
      });

      if (selected) {
        setImageFilePath(selected as string);
        setImageMifPath('');
        setSuccessMifPath('');
        setSuccessVPath('');
      }
    } catch (err) {
      notifications.show({
        title: t('ram.error'),
        message: t('ram.selectImageFailed', { error: err }),
        color: 'red',
      });
    }
  };

  interface MifGenerationResult {
    mifPath: string;
    vPath: string;
    previewPath?: string;
  }

  const convertImageToMif = async (): Promise<MifGenerationResult | null> => {
    if (!imageFilePath) return null;
    
    const outputDir = await getOutputDir();
    if (!outputDir) {
      notifications.show({
        title: t('ram.error'),
        message: t('ram.noProjectOpen'),
        color: 'red',
      });
      return null;
    }

    try {
      const fileName = imageFilePath.split(/[\\/]/).pop() || 'image';
      const baseName = fileName.replace(/\.[^/.]+$/, '');
      const mifPath = await join(outputDir, `${baseName}.mif`);
      const ext = fileName.match(/\.[^/.]+$/)?.[0] || '.png';
      const previewPath = await join(outputDir, `${baseName}_preview${ext}`);
      try {
        if (await exists(mifPath)) {
          await remove(mifPath);
        }
      } catch (e) {
      }
      try {
        if (await exists(previewPath)) {
          await remove(previewPath);
        }
      } catch (e) {
      }
      const inputDir = await getDirOfFile(imageFilePath);
      const imgFileName = imageFilePath.split(/[\\/]/).pop() as string;
      
      const command = Command.sidecar(
        'binaries/ip-generator/img2mif',
        [imgFileName, '-o', mifPath, '-p', previewPath],
        { cwd: inputDir }
      );
      
      const result = await command.execute();
      
      if (result.code === 0) {
        const vPath = mifPath.replace(/\.mif$/i, '.v');
        return { mifPath, vPath, previewPath };
      } else {
        notifications.show({
          title: t('ram.error'),
          message: t('ram.img2mifFailed', { code: result.code, stderr: result.stderr }),
          color: 'red',
        });
        return null;
      }
    } catch (err) {
      notifications.show({
        title: t('ram.error'),
        message: t('ram.img2mifFailed', { error: err }),
        color: 'red',
      });
      return null;
    }
  };

  const generateSinglePortMifContent = (w: number, d: number): string => {
    const lines: string[] = [];
    lines.push(`WIDTH=${w};`);
    lines.push(`DEPTH=${d};`);
    lines.push('');
    lines.push('ADDRESS_RADIX=HEX;');
    lines.push('DATA_RADIX=HEX;');
    lines.push('');
    lines.push('CONTENT BEGIN');
    
    const dataHexDigits = Math.ceil(w / 4);
    const zeroData = '0'.repeat(dataHexDigits);
    const addrHexDigits = Math.max(1, Math.ceil(Math.log2(d) / 4));
    
    for (let i = 0; i < d; i++) {
      const addr = i.toString(16).toUpperCase().padStart(addrHexDigits, '0');
      lines.push(`    ${addr} : ${zeroData};`);
    }
    
    lines.push('END;');
    return lines.join('\n');
  };

  const generateDualPortMifContent = (widthA: number, depthA: number, widthB: number, depthB: number): string => {
    const lines: string[] = [];
    lines.push(`WIDTHA=${widthA};`);
    lines.push(`DEPTHA=${depthA};`);
    lines.push(`WIDTHB=${widthB};`);
    lines.push(`DEPTHB=${depthB};`);
    lines.push('');
    lines.push('ADDRESS_RADIX=HEX;');
    lines.push('DATA_RADIX=HEX;');
    lines.push('');
    lines.push('CONTENT BEGIN');
    
    const dataHexDigits = Math.ceil(widthA / 4);
    const zeroData = '0'.repeat(dataHexDigits);
    const addrHexDigits = Math.max(1, Math.ceil(Math.log2(depthA) / 4));
    
    for (let i = 0; i < depthA; i++) {
      const addr = i.toString(16).toUpperCase().padStart(addrHexDigits, '0');
      lines.push(`    ${addr} : ${zeroData};`);
    }
    
    lines.push('END;');
    return lines.join('\n');
  };

  const getOutputDir = async (): Promise<string | null> => {
    if (project) {
      const projectDir = await dirname(project.path);
      const ipDir = await join(projectDir, 'IP');
      try {
        await mkdir(ipDir, { recursive: true });
      } catch (e) {
      }
      return ipDir;
    }
    return null;
  };

  const generateMifFile = async (): Promise<MifGenerationResult | null> => {
    const outputDir = await getOutputDir();
    if (!outputDir) {
      notifications.show({
        title: t('ram.error'),
        message: t('ram.noProjectOpen'),
        color: 'red',
      });
      return null;
    }

    try {
      try {
        await mkdir(outputDir, { recursive: true });
      } catch (e) {
      }
      let fileName: string;
      let mifContent: string;

      if (ramType === 'single') {
        const config = RAM_CONFIG_OPTIONS.find(c => c.value === singleConfig);
        if (!config) return null;
        fileName = `ram_single_${config.width}x${config.depth}.mif`;
        mifContent = generateSinglePortMifContent(config.width, config.depth);
      } else {
        const configA = RAM_CONFIG_OPTIONS.find(c => c.value === portAConfig);
        const configB = RAM_CONFIG_OPTIONS.find(c => c.value === portBConfig);
        if (!configA || !configB) return null;
        fileName = `ram_dual_A${configA.width}x${configA.depth}_B${configB.width}x${configB.depth}.mif`;
        mifContent = generateDualPortMifContent(configA.width, configA.depth, configB.width, configB.depth);
      }
      
      const mifPath = await join(outputDir, fileName);
      const vPath = mifPath.replace(/\.mif$/i, '.v');
      await writeTextFile(mifPath, mifContent);
      setGeneratedMifPath(mifPath);
      
      return { mifPath, vPath };
    } catch (err) {
      notifications.show({
        title: t('ram.error'),
        message: t('ram.generateMifFailed', { error: err }),
        color: 'red',
      });
      return null;
    }
  };

  const prepareMifFile = async (): Promise<MifGenerationResult | null> => {
    if (inputMode === 'file') {
      if (!mifFilePath) {
        notifications.show({
          title: t('ram.error'),
          message: t('ram.noFileSelected'),
          color: 'red',
        });
        return null;
      }

      try {
        if (!(await exists(mifFilePath))) {
          notifications.show({
            title: t('ram.error'),
            message: t('ram.fileNotExist', { file: mifFilePath }),
            color: 'red',
          });
          return null;
        }
      } catch (verifyError) {
      }
      const outputDir = await getOutputDir();
      if (!outputDir) {
        notifications.show({
          title: t('ram.error'),
          message: t('ram.noProjectOpen'),
          color: 'red',
        });
        return null;
      }
      const fileName = mifFilePath.split(/[\\/]/).pop() as string;
      const vPath = (await join(outputDir, fileName)).replace(/\.mif$/i, '.v');
      return { mifPath: mifFilePath, vPath };
    } else if (inputMode === 'image') {
      if (!imageFilePath) {
        notifications.show({
          title: t('ram.error'),
          message: t('ram.noImageSelected', 'Please select an image file'),
          color: 'red',
        });
        return null;
      }
      return await convertImageToMif();
    } else {
      return await generateMifFile();
    }
  };

  const handleSubmit = async () => {
    const prepareResult = await prepareMifFile();
    if (!prepareResult) {
      return;
    }
    
    const { mifPath: targetMifPath, vPath: expectedVPath, previewPath } = prepareResult;
    if (inputMode === 'image' && previewPath) {
      setPreviewImagePath(previewPath);
    }

    setIsProcessing(true);
    setSuccessMifPath('');
    setSuccessVPath('');
    const outputDir = await getOutputDir();
    
    if (!outputDir) {
      notifications.show({
        title: t('ram.error'),
        message: t('ram.noProjectOpen'),
        color: 'red',
      });
      setIsProcessing(false);
      return;
    }

    const fileName = targetMifPath.split(/[\\/]/).pop() as string;
    try {
      const vFileName = fileName.replace(/\.mif$/i, '.v');
      const vFilePath = await join(outputDir, vFileName);
      if (await exists(vFilePath)) {
        await remove(vFilePath);
      }
    } catch (e) {
    }
    const command = Command.sidecar('binaries/ip-generator/ip_generator', ['bram', targetMifPath], { cwd: outputDir });

    const notifyId = notifications.show({
      title: t('flow.notify.running.title'),
      message:
        t('flow.notify.running.message_prefix') +
        t('ram.config.title') +
        t('flow.notify.running.message_suffix'),
      autoClose: false,
      loading: true,
    });

    try {
      const { code } = await command.execute();

      if (code === 0) {
        if (inputMode === 'param') {
          setSuccessMifPath(targetMifPath);
        }
        if (inputMode === 'image') {
          setImageMifPath(targetMifPath);
        }
        setSuccessVPath(expectedVPath);
        
        update2SuccessNotification({
          id: notifyId,
          title: t('ram.config.title'),
          message:
            t('flow.notify.success.message_prefix') +
            t('ram.config.title') +
            t('flow.notify.success.message_suffix'),
        });
      } else {
        update2FailedNotification({
          id: notifyId,
          title: t('ram.config.title'),
          message:
            t('flow.notify.failed.message_prefix') +
            t('ram.config.title') +
            t('flow.notify.failed.message_suffix') +
            ': ' + `Code = ${code}`,
        });
      }
    } catch (err) {
      update2FailedNotification({
        id: notifyId,
        title: t('ram.config.title'),
        message:
          t('flow.notify.failed.message_prefix') +
          t('ram.config.title') +
          t('flow.notify.failed.message_suffix') +
          ': ' + err,
      });
    } finally {
      setIsProcessing(false);
    }
  };

  const handleReset = () => {
    setMifFilePath('');
    setRamType('single');
    setSingleConfig('8_512');
    setPortAConfig('8_512');
    setPortBConfig('16_256');
    setGeneratedMifPath('');
    setSuccessMifPath('');
    setSuccessVPath('');
    setImageFilePath('');
    setImageMifPath('');
    setPreviewImagePath('');
  };

  const isSubmitDisabled = () => {
    if (isProcessing) return true;
    if (inputMode === 'file') {
      return !mifFilePath;
    }
    if (inputMode === 'image') {
      return !imageFilePath || !project;
    }
    return !project;
  };

  const portBCompatibleConfigs = getCompatibleConfigs(portAConfig);

  return (
    <>
      <Stack gap="sm">
        <Title order={3}>{t('ram.config.title')}</Title>
        <Text c="dimmed" size="sm">{t('ram.config.description')}</Text>

        <Tabs value={inputMode} onChange={(v) => setInputMode(v as InputMode)}>
          <Tabs.List>
            <Tabs.Tab value="file" leftSection={<TbFile size={16} />}>
              {t('ram.fileMode')}
            </Tabs.Tab>
            <Tabs.Tab value="param" leftSection={<TbSettings size={16} />}>
              {t('ram.paramMode')}
            </Tabs.Tab>
            <Tabs.Tab value="image" leftSection={<TbPhoto size={16} />}>
              {t('ram.imageMode', 'Image to MIF')}
            </Tabs.Tab>
          </Tabs.List>

          <Tabs.Panel value="file" pt="sm">
            <Card withBorder padding="sm">
              <Group align="flex-end">
                <TextInput
                  label={t('ram.mifFilePath')}
                  value={mifFilePath}
                  readOnly
                  placeholder={t('ram.noFilePlaceholder')}
                  style={{ flex: 1 }}
                  size="sm"
                />
                <Button leftSection={<TbUpload size={16} />} onClick={handleSelectFile} variant="light" size="sm">
                  {t('ram.selectMifButton')}
                </Button>
              </Group>
            </Card>
            {successVPath && inputMode === 'file' && (
              <Text size="xs" c="dimmed">
                {t('ram.outputFile')}: {successVPath}
              </Text>
            )}
          </Tabs.Panel>

          <Tabs.Panel value="param" pt="sm">
            <Stack gap="sm">
              {!project && (
                <Alert icon={<TbInfoCircle size={16} />} color="orange" variant="light" p="xs">
                  {t('ram.noProjectOpen')}
                </Alert>
              )}

              <Card withBorder padding="sm">
                <Radio.Group
                  label={t('ram.ramType')}
                  value={ramType}
                  onChange={(v) => setRamType(v as RamType)}
                  size="sm"
                >
                  <Group mt="xs">
                    <Radio value="single" label={t('ram.singlePort')} size="sm" />
                    <Radio value="dual" label={t('ram.dualPort')} size="sm" />
                  </Group>
                </Radio.Group>
              </Card>

              {ramType === 'single' ? (
                <Card withBorder padding="sm">
                  <Select
                    label={t('ram.configSelect')}
                    description={t('ram.configSelectDescription')}
                    data={RAM_CONFIG_OPTIONS.map(c => ({ value: c.value, label: `${c.label} (${formatBits(c.width * c.depth)})` }))}
                    value={singleConfig}
                    onChange={(v) => v && setSingleConfig(v)}
                    size="sm"
                  />
                </Card>
              ) : (
                <Card withBorder padding="sm">
                  <Stack gap="sm">
                    <Select
                      label={t('ram.portAConfig')}
                      description={t('ram.portADescription')}
                      data={RAM_CONFIG_OPTIONS.map(c => ({ value: c.value, label: `${c.label} (${formatBits(c.width * c.depth)})` }))}
                      value={portAConfig}
                      onChange={(v) => v && setPortAConfig(v)}
                      size="sm"
                    />
                    <Select
                      label={t('ram.portBConfig')}
                      description={t('ram.portBDescription')}
                      data={portBCompatibleConfigs.map(c => ({ value: c.value, label: `${c.label} (${formatBits(c.width * c.depth)})` }))}
                      value={portBConfig}
                      onChange={(v) => v && setPortBConfig(v)}
                      size="sm"
                    />
                    <Text size="xs" c="dimmed">
                      {t('ram.capacityInfo', { 
                        portA: getTotalBits(portAConfig), 
                        portB: getTotalBits(portBConfig) 
                      })}
                    </Text>
                  </Stack>
                </Card>
              )}

              {(successMifPath || successVPath) && inputMode === 'param' && (
                <Stack gap={4}>
                  {successMifPath && (
                    <Text size="xs" c="dimmed">
                      {t('ram.generatedMif')}: {successMifPath}
                    </Text>
                  )}
                  {successVPath && (
                    <Text size="xs" c="dimmed">
                      {t('ram.outputFile')}: {successVPath}
                    </Text>
                  )}
                </Stack>
              )}
            </Stack>
          </Tabs.Panel>

          <Tabs.Panel value="image" pt="sm">
            <Stack gap="sm">
              {!project && (
                <Alert icon={<TbInfoCircle size={16} />} color="orange" variant="light" p="xs">
                  {t('ram.noProjectOpen')}
                </Alert>
              )}

              <Card withBorder padding="sm">
                <Stack gap="sm">
                  <Group align="flex-end">
                    <TextInput
                      label={t('ram.imageFilePath', 'Image File')}
                      value={imageFilePath}
                      readOnly
                      placeholder={t('ram.noImagePlaceholder', 'Select an image file (PNG/JPG/BMP)')}
                      style={{ flex: 1 }}
                      size="sm"
                      leftSection={<TbPhoto size={16} />}
                    />
                    <Button 
                      leftSection={<TbUpload size={16} />} 
                      onClick={handleSelectImage} 
                      variant="light" 
                      size="sm"
                      disabled={isProcessing}
                    >
                      {t('ram.selectImageButton', 'Select Image')}
                    </Button>
                  </Group>

                  <Text size="xs" c="dimmed">
                    {t('ram.imageConvertInfo', 'Image will be converted to 128x64 pixels and output as 8-bit width MIF file (1024 depth)')}
                  </Text>
                </Stack>
              </Card>

              {(previewImagePath || imageMifPath || successVPath) && inputMode === 'image' && (
                <Stack gap={4}>
                  {previewImagePath && (
                    <Text size="xs" c="dimmed">
                      {t('ram.previewImagePath', 'Preview image')}: {previewImagePath}
                    </Text>
                  )}
                  {imageMifPath && (
                    <Text size="xs" c="dimmed">
                      {t('ram.generatedMif')}: {imageMifPath}
                    </Text>
                  )}
                  {successVPath && (
                    <Text size="xs" c="dimmed">
                      {t('ram.outputFile')}: {successVPath}
                    </Text>
                  )}
                </Stack>
              )}
            </Stack>
          </Tabs.Panel>
        </Tabs>

        <Group justify="flex-end" mt="sm">
          <Button variant="outline" onClick={handleReset} disabled={isProcessing} size="sm">
            {t('ram.resetButton')}
          </Button>
          <Button
            leftSection={<TbPray size={16} />}
            onClick={handleSubmit}
            loading={isProcessing}
            disabled={isSubmitDisabled()}
            size="sm"
          >
            {isProcessing ? t('ram.processing') : t('ram.generateButton')}
          </Button>
        </Group>
      </Stack>


    </>
  );
};

export default RAMConfig;
