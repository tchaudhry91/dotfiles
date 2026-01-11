import { appendFileSync } from "fs"
import { homedir } from "os"

export async function BashHistoryPlugin() {
  const historyFile = `${homedir()}/.opencode_zsh_history`

  return {
    "tool.execute.before": async (input, output) => {
      if (input?.tool === "bash" && output?.args?.command) {
        const timestamp = Math.floor(Date.now() / 1000)
        appendFileSync(historyFile, `: ${timestamp}:0;${output.args.command}\n`)
      }
    },
  }
}
