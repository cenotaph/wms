var usbd = {};
let device;
let deviceEndpoint = 0x02;

let powerUpDevice = new Uint8Array([0x62,0x00, 0x00, 0x00, 0x00,0x00,0x00,0x01,0x00, 0x00]).buffer;
let getCardUID = new Uint8Array([0xff,0xca,0x00,0x00,0x04]).buffer;

(function() {
    'use strict';

    usbd.authorize = function(){
        navigator.usb.requestDevice({ filters: [{ vendorId: 0x072f }] })
            .then(selectedDevice => {
                device = selectedDevice;
                console.log('interface is ' + device.configuration.interfaces[0].interfaceNumber);
                console.log(device.manufacturerName);
                console.log(device.productName);
                console.log(device);
                return device.open()
                    .then(() => {
                        if (device.configuration === null) {
                            return device.selectConfiguration(1);
                        }
                    });
            })
            .then(() => device.claimInterface(0))
            .then(() => device.transferOut(deviceEndpoint, powerUpDevice)
                .then(transferResult => {
                    console.log('powered up:  ' + transferResult);
                }, error => {
                    console.log(error);
                    device.close();
                })
                .catch(error => {
                    console.log(error);
                })
            );

    };

    usbd.getDevice = function(){
        return navigator.usb.getDevices().then(devices => {
            return devices.map(device => new usbd.device(device));
        });
    };

    usbd.device = function(device) {
        this.device_ = device;
    };

    usbd.getTagUID = function(){
        device = this.getDevice();

        device
            .then(device => {
                device[0].device_.open()
                    .then(() => {
                      console.log('opened')
                      device[0].device_.claimInterface(0)
                      console.log('claimed interface')
                    })
                    .then(() => { 
                        console.log('transfer out starting...')
                         return device[0].device_.transferOut(deviceEndpoint, getCardUID)
                      })
                        .then(transferResult => {
                            console.log('result: ' + transferResult);
                        }, error => {
                            console.log('error: ' + error);
                            device[0].device_.close();
                        })
                        .catch(error => {
                            console.log(error);
                        })
                    
                    .then(() => device[0].device_.claimInterface(0))
                    .then(() => device[0].device_.transferIn(deviceEndpoint, 16)
                        .then(USBInTransferResult => {
                            if (USBInTransferResult.data) {
                                console.log(USBInTransferResult.data.getUint32(0));
                            }
                        }, error => {
                            console.log(error);
                            device[0].device_.close();
                        })
                        .catch(error => {
                            console.log(error);
                        })
                    );
            });
    };


})();

document.addEventListener('DOMContentLoaded', event => {

  //let button = document.getElementById('connect')
    $('#connect').click(function(){
        usbd.authorize();
        $('#readcard').removeAttr('disabled')
    });

    $('#readcard').click(function(){
        usbd.getTagUID();
    });

  // button.addEventListener('click', async() => {

  //   let device
  //   const VENDOR_ID = 0x072f
    
  //   try {
  //     device = await navigator.usb.requestDevice({
  //       filters: [{
  //         vendorId: VENDOR_ID
  //       }]
  //     })

  //     console.log('open')
  //     await device.open()
  //     console.log('opened:', device)

  //   } catch (error) {
  //     console.log(error)
  //   }
  //   await device.close()
  // })

})
