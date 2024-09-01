import request from 'request'
import chrome from 'chrome-cookies-secure'

export default async (url) => {
  const urlObj = new URL(url)
  return new Promise((resolve, reject) => {
    chrome.getCookies(urlObj.origin, 'jar', function (err, jar) {
      request(
        {
          url,
          jar: jar
        },
        function (err, response, body) {
          if (err) {
            return reject(err)
          }
          resolve(body)
        }
      )
    })
  })
}