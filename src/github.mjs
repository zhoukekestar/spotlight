#!/usr/bin/env zx

import fetch from './fetch.mjs'
import { JSDOM } from 'jsdom'
import ora from 'ora'

// 使用代理
process.env['http_proxy'] = 'http://127.0.0.1:1088';
process.env['https_proxy'] = 'http://127.0.0.1:1088';

const spinner = ora('请求 github...').start()
const timer = setTimeout(() => {
  spinner.text = 'Github 请求过久的话，请确认是否能正常访问...'
}, 3000)

try {
  const githubHtml = await fetch(`https://github.com/`)

  const { document } = new JSDOM(githubHtml).window

  const githubName = document.head.querySelector(
    'meta[name=user-login]'
  ).content

  console.log(`\n\n###\n\nHey! You are ${githubName} 🎉\n\n###\n\n`)
} catch (err) {
  spinner.text = '网络异常！'
}
clearTimeout(timer)
spinner.stop()
// console.log(githubHtml)
