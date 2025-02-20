import { NitroModules } from 'react-native-nitro-modules';
import type { RnSimaAppToApp, SimaData } from './RnSimaAppToApp.nitro';

const RnSimaAppToAppHybridObject =
  NitroModules.createHybridObject<RnSimaAppToApp>('RnSimaAppToApp');

export function startSimaAuth(data: SimaData): Promise<string> {
  return RnSimaAppToAppHybridObject.startSimaAuth(data);
}
