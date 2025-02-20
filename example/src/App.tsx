import { useState } from 'react';
import { View, StyleSheet, TextInput, Button, Linking } from 'react-native';
import { startSimaAuth } from 'rn-sima-app-to-app';
import base64Example from './assets/images/base64Example';
const HomeScreen = () => {
  const [pinCode, setPinCode] = useState('');

  const handlePress = async () => {
    try {
      startSimaAuth({
        scheme: '',
        serviceName: '',
        userPinCode: pinCode,
        logo: base64Example,
        clientId: 0,
        masterKey: '',
      })
        .then((res) => {
          console.log('res', JSON.parse(res));
        })
        .catch((error) => {
          console.error('error', error);
        });
    } catch (error) {
      console.log('error', error);
    }
  };

  Linking.getInitialURL().then((url) => {
    console.log({ url });
  });

  return (
    <View>
      <TextInput
        style={{ borderWidth: 1, width: 200 }}
        onChangeText={(text) => setPinCode(text)}
      />
      <Button title="Sima" onPress={handlePress} />
    </View>
  );
};

export default function App() {
  return (
    <View style={styles.container}>
      <HomeScreen />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
  },
});
