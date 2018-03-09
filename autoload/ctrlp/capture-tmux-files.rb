#!/usr/bin/env ruby

input = ARGV[0]

# example: capture-tmux-files.rb "main:ui.0;app/views;erb;Started GET"

tmux_pane, file_prefix, extension, block_delimiter = input.split(';')

output = `tmux capture-pane -t #{tmux_pane} -pS -500`
output = output.lines.map(&:strip)

uniq_output = []

output.reverse.each { |line|
  if line.include?(block_delimiter) && !uniq_output.empty?
    break
  end
  matched = line[/[^ ]+.#{extension}:\d+/] || line[/[^ ]+.#{extension}/]
  if matched && matched.include?('/') && !uniq_output.include?(matched)
    uniq_output << matched
  end
}

uniq_output.delete('text')

puts uniq_output.map { |line|
  if line.start_with?(file_prefix)
    line
  else
    "#{file_prefix}/#{line}"
  end
}.reverse.join("\n")
