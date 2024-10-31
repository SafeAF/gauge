// app/javascript/controllers/ram_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gauge"]

  connect() {
    this.fetchRamUsage()
    this.initializeGauge()
    this.startPolling()
  }

  initializeGauge() {
    var opts = {
      angle: 0.15,
      lineWidth: 0.44,
      radiusScale: 1,
      pointer: {
        length: 0.6,
        strokeWidth: 0.035,
        color: '#000000'
      },
      limitMax: false,
      limitMin: false,
      colorStart: '#6FADCF',
      colorStop: '#8FC0DA',
      strokeColor: '#E0E0E0',
      generateGradient: true,
      highDpiSupport: true,
    };

    const target = document.getElementById('gauge');
    this.gauge = new Gauge(target).setOptions(opts);
    this.gauge.maxValue = 100;
    this.gauge.setMinValue(0);
    this.gauge.animationSpeed = 32;
    this.gauge.set(0);
  }

  fetchRamUsage() {
    fetch('/ram_usage')
      .then(response => response.json())
      .then(data => {
        this.gauge.set(data.usage);
      });
  }

  startPolling() {
    setInterval(() => {
      this.fetchRamUsage()
    }, 5000)
  }
}
