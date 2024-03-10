import React, { useState } from 'react'
import { View, Text } from 'react-native'
import { BleManager, Device } from 'react-native-ble-plx'

export const manager = new BleManager()

const GetDeviceButton = () => {
  // const deviceList = [
  //   { name: 'test', id: '1' },
  //   { name: 'test2', id: '2' },
  // ]
  const [deviceList, setDeviceList] = useState<Device[]>([])

  React.useEffect(() => {
    const subscription = manager.onStateChange((state) => {
      if (state === 'PoweredOn') {
        scanAndConnect()
        subscription.remove()
      }
    }, true)
    return () => subscription.remove()
  }, [manager])

  const scanAndConnect = () => {
    manager.startDeviceScan(null, null, (error, device) => {
      if (error) {
        // Handle error (scanning will be stopped automatically)
        return
      }
      if (
        device &&
        device.name != null &&
        deviceList.findIndex((currDevice) => currDevice.id === device.id) == -1
      ) {
        // console.log(
        //   'device id: ' + device?.id + '\ndevice name: ' + device?.name + '\n\n'
        // )
        // cannot add device
        setDeviceList((prevDeviceList) => [...prevDeviceList, device])
        console.log(deviceList)
      }
      if (deviceList.length > 10) manager.stopDeviceScan()
      //   if (device.name === 'TI BLE Sensor Tag' || device.name === 'SensorTag') {
      //     // Stop scanning as it's not necessary if you are scanning for one device.
      //     manager.stopDeviceScan()

      //     // Proceed with connection.
      //   }
    })
  }
  // const device = { name: 'test2', id: '3' }
  // console.log(
  //   deviceList.findIndex((currDevice) => currDevice.id == device.id) == -1
  // )
  return (
    <View>
      {deviceList.map((device, index) => (
        <Text key={index}>
          name: {device.name} id: {device.id}
        </Text>
      ))}
    </View>
  )
}

export default GetDeviceButton
