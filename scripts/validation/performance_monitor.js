// Performance monitoring
export const performanceMetrics = {
  fps: 0,
  loadTime: 0,
  memoryUsage: 0
};

export function startMonitoring() {
  let frameCount = 0;
  let lastTime = performance.now();

  function measure() {
    const currentTime = performance.now();
    frameCount++;

    if (currentTime - lastTime > 1000) {
      performanceMetrics.fps = frameCount;
      frameCount = 0;
      lastTime = currentTime;
    }

    requestAnimationFrame(measure);
  }

  requestAnimationFrame(measure);
}
