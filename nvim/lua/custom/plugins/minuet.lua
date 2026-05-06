return {
  'milanglacier/minuet-ai.nvim',
  config = function()
    require('minuet').setup {
      -- Ollama Cloud via OpenAI-compatible endpoint
      provider = 'openai_compatible',
      provider_options = {
        openai_compatible = {
          model = 'deepseek-v4-flash:cloud',
          end_point = 'https://ollama.com/v1/chat/completions',
          api_key = 'OLLAMA_CLOUD_API_KEY',
          name = 'Ollama Cloud',
          stream = false,
          optional = {
            max_tokens = 512,
          },
        },
      },
      -- Opt-in only: manual trigger only, no auto-complete
      cmp = {
        enable_auto_complete = false,
      },
      notify = 'debug',
      request_timeout = 30,
      -- Reduce context sent to LLM for faster responses
      context_window = 4096,
      throttle = 1000,
      debounce = 400,
    }
  end,
}
