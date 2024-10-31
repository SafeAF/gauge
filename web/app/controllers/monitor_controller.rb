# app/controllers/monitor_controller.rb
class MonitorController < ApplicationController
  def ram_usage
    # Read memory info from /proc/meminfo and convert it into a hash
    meminfo = File.read("/proc/meminfo").each_line.map do |line|
      key, value = line.split(/\s+/, 3) # Split into key, value, and optional extra columns (like "kB")
      [key, value.to_i] # Convert value to integer (assuming it's in KB)
    end.to_h

    # Extract total and free memory in KB, then calculate the used memory percentage
    total_memory = meminfo["MemTotal:"]
    free_memory = meminfo["MemAvailable:"]
    used_memory = total_memory - free_memory

    usage_percentage = ((used_memory.to_f / total_memory) * 100).round(2)

    render json: { ram_usage: usage_percentage }
  end
end

