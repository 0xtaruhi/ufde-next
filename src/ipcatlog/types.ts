// src/ipcatlog/types.ts
import React from 'react';

export interface IPCore {
  id: string;
  name: string;
  description: string;
  icon: React.ElementType;
}

export interface RAMConfigData {
  mifPath: string;
  ramSize: number;
  dataWidth: number;
  ramType: string;
}

export interface PLLConfigData {
  divideValue: number;
  fpgaGates: number;
}

export interface BaseIPConfigProps {
  onConfigChange?: (config: any) => void;
}
