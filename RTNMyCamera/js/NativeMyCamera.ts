import type {TurboModule} from 'react-native/Libraries/TurboModule/RCTExport';
import {TurboModuleRegistry} from 'react-native';

export interface Spec extends TurboModule {
  takePhoto(): void;
}

export default TurboModuleRegistry.get<Spec>('RTNMyCamera') as Spec | null;
