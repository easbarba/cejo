# frozen_string_literal: true

# Get Cli Arguments
class Arguments
  def grab_guments(arguments)
    args = Queue.new

    arguments.each do |arg|
      args << arg
    end

    args
  end
end
