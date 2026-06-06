import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Container,
  Grid,
  Card,
  Stack,
  NavLink,
  ScrollArea,
  Title,
  Text,
  Box,
} from '@mantine/core';
import { TbCpu, TbDeviceFloppy, TbClock } from 'react-icons/tb';
import {
  RAMConfig,
  PLLConfig,
  IPCore,
  BaseIPConfigProps,
} from '../ipcatlog';

const ipCores: (IPCore & { component: React.ComponentType<BaseIPConfigProps> })[] = [
  {
    id: 'ram',
    name: 'RAM',
    description: 'ip.ram.description',
    icon: TbDeviceFloppy,
    component: RAMConfig,
  },
  {
    id: 'pll',
    name: 'PLL',
    description: 'ip.pll.description',
    icon: TbClock,
    component: PLLConfig,
  },
];

function IPPage() {
  const { t } = useTranslation();
  const [selectedIP, setSelectedIP] = useState<string | null>(null);
  const [, setIpConfigs] = useState<Record<string, any>>({});

  const handleConfigChange = (ipId: string, config: any) => {
    setIpConfigs(prev => ({ ...prev, [ipId]: config }));
  };

  const selectedIPData = ipCores.find(ip => ip.id === selectedIP);
  const ConfigComponent = selectedIPData?.component;

  return (
    <Container fluid p="md" h="100%">
      <Title order={2} mb="md">{t('ip.title')}</Title>
      <Text c="dimmed" mb="lg">{t('ip.subtitle')}</Text>

      <Grid gap="md" h="calc(100% - 80px)">
        <Grid.Col span={4}>
          <Card shadow="sm" withBorder h="100%" p="md">
            <Title order={4} mb="md">{t('ip.available')}</Title>
            <ScrollArea h="calc(100% - 60px)">
              <Stack gap="xs">
                {ipCores.map(ip => {
                  const Icon = ip.icon;
                  const isSelected = selectedIP === ip.id;
                  const showGreenDot = isSelected;
                  return (
                    <NavLink
                      key={ip.id}
                      label={
                        <Box>
                          <Text fw={500}>{t(ip.name)}</Text>
                          <Text size="xs" c="dimmed">{t(ip.description)}</Text>
                        </Box>
                      }
                      leftSection={<Icon size={20} />}
                      rightSection={showGreenDot && <Box w={8} h={8} bg="green" style={{ borderRadius: '50%' }} />}
                      active={isSelected}
                      onClick={() => setSelectedIP(ip.id)}
                      variant="light"
                      color={isSelected ? 'blue' : 'gray'}
                      style={{ borderRadius: 'var(--mantine-radius-sm)' }}
                    />
                  );
                })}
              </Stack>
            </ScrollArea>
          </Card>
        </Grid.Col>

        <Grid.Col span={8}>
          <Card shadow="sm" withBorder h="100%" p="md">
            <Title order={4} mb="md">{t('ip.configuration')}</Title>
            <ScrollArea h="calc(100% - 60px)">
              {selectedIP && ConfigComponent ? (
                <Box p="xs">
                  <ConfigComponent
                    onConfigChange={(config: any) => handleConfigChange(selectedIP, config)}
                  />
                </Box>
              ) : (
                <Box
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    height: '100%',
                    minHeight: 300,
                  }}
                >
                  <Stack align="center" gap="xs">
                    <TbCpu size={48} color="var(--mantine-color-gray-4)" />
                    <Text c="dimmed" size="lg">{t('ip.selectPrompt')}</Text>
                  </Stack>
                </Box>
              )}
            </ScrollArea>
          </Card>
        </Grid.Col>
      </Grid>
    </Container>
  );
}

export default IPPage;
