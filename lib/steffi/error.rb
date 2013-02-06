module Steffi
  module Igraph
    callback :error_handler, [:string, :string, :int, :int], :void

    bind :set_error_handler, [:error_handler], :error_handler
    bind :strerror, [:int], :string

    class Error < StandardError; end

    ErrorHandler = Proc.new do |reason, file, line, code|
      raise Error.new "#{strerror code}: #{reason} (#{file}:#{line}"
    end

    set_error_handler ErrorHandler
  end
end