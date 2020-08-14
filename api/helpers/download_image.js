const fs = require('fs')
const path = require('path')
const axios = require('axios')
const downloadImage = async (url, downloadPath) => {
  const downPath = path.resolve(downloadPath)
  const writer = fs.createWriteStream(downPath)
  const response = await axios({
    url,
    method: 'GET',
    responseType: 'stream'
  })
  response.data.pipe(writer)
  return new Promise((resolve, reject) => {
    writer.on('finish', (e) => {
      console.log(e)
      resolve(e)
    })
    writer.on('error', reject)
  })
}
module.exports = downloadImage
