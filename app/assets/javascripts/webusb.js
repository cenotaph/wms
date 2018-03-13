document.addEventListener('DOMContentLoaded', event => {

  let button = document.getElementById('connect')

  button.addEventListener('click', async() => {

    let device
    const VENDOR_ID = 0x072f
    
    try {
      device = await navigator.usb.requestDevice({
        filters: [{
          vendorId: VENDOR_ID
        }]
      })

      console.log('open')
      await device.open()
      console.log('opened:', device)
    } catch (error) {
      console.log(error)
    }
    await device.close()
  })

})
