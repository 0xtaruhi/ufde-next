// src/ipcatlog/PLLConfig.tsx
import React, { useState, useEffect, useContext, useRef } from 'react';
import {
  Stack,
  Card,
  Button,
  Title,
  Text,
  Group,
  Select,
  Alert,
} from '@mantine/core';
import { TbInfoCircle } from 'react-icons/tb';
import { Command } from '@tauri-apps/plugin-shell';
import { BaseIPConfigProps } from './types';
import { notifications } from '@mantine/notifications';
import { update2SuccessNotification, update2FailedNotification } from '../pages/Notifies';
import { useTranslation } from 'react-i18next';
import { dirname, join } from '@tauri-apps/api/path';
import { mkdir } from '@tauri-apps/plugin-fs';
import { ProjectContext } from '../App';

interface PLLConfigProps extends BaseIPConfigProps {}

const formatError = (err: unknown): string => err instanceof Error ? err.message : String(err);

const DIVIDE_OPTIONS = [
  { value: '2', label: '2' },
  { value: '4', label: '4' },
  { value: '8', label: '8' },
  { value: '16', label: '16' },
];

const FPGA_GATE_OPTIONS = [
  { value: '30', label: '30W(DLL)' },
  { value: '50', label: '50W(DCM)' },
];

const PLLConfig: React.FC<PLLConfigProps> = ({ onConfigChange }) => {
  const { t } = useTranslation();
  const { project } = useContext(ProjectContext);

  const [divideValue, setDivideValue] = useState<string>('2');
  const [fpgaGates, setFpgaGates] = useState<string>('30');
  const [isProcessing, setIsProcessing] = useState<boolean>(false);
  const [successOutputPath, setSuccessOutputPath] = useState<string>('');

  useEffect(() => {
    setSuccessOutputPath('');
  }, [divideValue, fpgaGates]);

  const onConfigChangeRef = useRef(onConfigChange);
  onConfigChangeRef.current = onConfigChange;

  useEffect(() => {
    if (onConfigChangeRef.current) {
      onConfigChangeRef.current({
        divideValue: parseInt(divideValue),
        fpgaGates: parseInt(fpgaGates),
      });
    }
  }, [divideValue, fpgaGates]);

  const getOutputDir = async (): Promise<string | null> => {
    if (project) {
      const projectDir = await dirname(project.path);
      const ipDir = await join(projectDir, 'IP');
      await mkdir(ipDir, { recursive: true });
      return ipDir;
    }
    return null;
  };

  const handleSubmit = async () => {
    setIsProcessing(true);
    setSuccessOutputPath('');
    let notifyId: string | undefined;

    try {
      const outputDir = await getOutputDir();
      if (!outputDir) {
        notifications.show({
          title: t('pll.error'),
          message: t('pll.noProjectOpen'),
          color: 'red',
        });
        return;
      }

      const outputFile = `PLL_${divideValue}_${fpgaGates}.v`;
      const fullOutputPath = await join(outputDir, outputFile);

      const command = Command.sidecar('binaries/ip-generator/ip_generator', [
        'pll',
        '--divide', divideValue,
        '--gates', fpgaGates,
        '--output', outputFile,
      ], { cwd: outputDir });

      notifyId = notifications.show({
        title: t('flow.notify.running.title'),
        message:
          t('flow.notify.running.message_prefix') +
          t('pll.config.title') +
          t('flow.notify.running.message_suffix'),
        autoClose: false,
        loading: true,
      });

      const { code, stdout, stderr } = await command.execute();

      let result;
      try {
        result = JSON.parse(stdout);
      } catch (e) {
        result = { success: code === 0, message: stdout || stderr };
      }

      if (code === 0 && result.success) {
        setSuccessOutputPath(fullOutputPath);
        update2SuccessNotification({
          id: notifyId,
          title: t('pll.config.title'),
          message:
            t('flow.notify.success.message_prefix') +
            t('pll.config.title') +
            t('flow.notify.success.message_suffix'),
        });
      } else {
        update2FailedNotification({
          id: notifyId,
          title: t('pll.config.title'),
          message: result.message || result.error || stderr || t('pll.unknownError'),
        });
      }
    } catch (err) {
      const errMsg = formatError(err);
      const message =
        t('flow.notify.failed.message_prefix') +
        t('pll.config.title') +
        t('flow.notify.failed.message_suffix') +
        ': ' + errMsg;

      if (notifyId) {
        update2FailedNotification({
          id: notifyId,
          title: t('pll.config.title'),
          message,
        });
      } else {
        notifications.show({
          title: t('pll.config.title'),
          message,
          color: 'red',
        });
      }
    } finally {
      setIsProcessing(false);
    }
  };

  const handleReset = () => {
    setDivideValue('2');
    setFpgaGates('30');
    setSuccessOutputPath('');
  };

  const isSubmitDisabled = () => {
    if (isProcessing) return true;
    return !project;
  };

  return (
    <Stack gap="sm">
      <Title order={3}>{t('pll.config.title')}</Title>
      <Text c="dimmed" size="sm">{t('pll.config.description')}</Text>

      {!project && (
        <Alert icon={<TbInfoCircle size={16} />} color="orange" variant="light" p="xs">
          {t('pll.noProjectOpen')}
        </Alert>
      )}

      <Card withBorder padding="sm">
        <Stack gap="sm">
          <Select
            label={t('pll.divideValue')}
            description={t('pll.divideValueDescription')}
            data={DIVIDE_OPTIONS}
            value={divideValue}
            onChange={(v) => v && setDivideValue(v)}
            size="sm"
          />
          <Select
            label={t('pll.fpgaGates')}
            description={t('pll.fpgaGatesDescription')}
            data={FPGA_GATE_OPTIONS}
            value={fpgaGates}
            onChange={(v) => v && setFpgaGates(v)}
            size="sm"
          />
        </Stack>
      </Card>

      {successOutputPath && (
        <Text size="xs" c="dimmed">
          {t('pll.outputFile')}: {successOutputPath}
        </Text>
      )}

      <Group justify="flex-end" mt="sm">
        <Button variant="outline" onClick={handleReset} disabled={isProcessing} size="sm">
          {t('pll.resetButton')}
        </Button>
        <Button
          onClick={handleSubmit}
          loading={isProcessing}
          disabled={isSubmitDisabled()}
          size="sm"
        >
          {isProcessing ? t('pll.processing') : t('pll.generateButton')}
        </Button>
      </Group>
    </Stack>
  );
};

export default PLLConfig;
