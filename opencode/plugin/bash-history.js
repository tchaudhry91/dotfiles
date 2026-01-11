export const BashHistoryPlugin = async ({ $ }) => {
  return {
    "tool.execute.after": async (input, output) => {
      if (input.tool === "bash" && output.args?.command) {
        await $`echo ": $(date +%s):0;${output.args.command}" >> ~/.opencode_zsh_history`
      }
    }
  }
}
