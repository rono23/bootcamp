import MarkdownItRegexp from 'markdown-it-regexp'

export default MarkdownItRegexp(
  /@(?!mentor)([a-zA-Z0-9_-]+)/,

  (match) => {
    return `<a href="/users/${match[1]}">${match[0]}</a>`
  }
)
