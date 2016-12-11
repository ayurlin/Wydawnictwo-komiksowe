class BumJob < ApplicationJob
  queue_as :default

  def perform
    raise "exception notification testing"
  end
end
