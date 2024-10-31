# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @ram_usage = current_ram_usage
  end

  def ram_usage
    render json: { usage: current_ram_usage }
  end

  private

  def current_ram_usage
    case RUBY_PLATFORM
    when /linux/
      `free -m | awk '/Mem:/ { printf("%.2f", $3/$2 * 100.0) }'`.strip
    when /darwin/ # macOS
      `ps -caxm -orss= | awk '{ sum += $1 } END { printf("%.2f", sum/1024/1024) }'`.strip
    when /mingw|mswin/ # Windows
      `wmic OS get FreePhysicalMemory,TotalVisibleMemorySize /Value`.lines.map { |l| l.split('=')[1].to_i }.inject { |total, free| (1 - free.to_f / total) * 100 }.round(2)
    else
      'Unknown OS'
    end
  end
end
