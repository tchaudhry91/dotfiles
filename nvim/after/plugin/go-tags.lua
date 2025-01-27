require('go-tags').setup {
  commands = {
    ['GoTagsAddJSON'] = { '-add-tags', 'json' },
    ['GoTagsRemoveJSON'] = { '-remove-tags', 'json' },
  },
}
