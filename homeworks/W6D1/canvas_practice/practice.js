document.addEventListener('DOMContentLoaded', function() {
  const canvas = document.getElementById('mycanvas');
  canvas.width = 500;
  canvas.height = 500;

  const ctx = canvas.getContext('2d');

  ctx.fillStyle = 'green';

  // void ctx.fillRect(x, y, width, height);
  ctx.fillRect(0, 0, 500, 500);

  ctx.beginPath();

  // void ctx.arc(x, y, radius, startAngle, endAngle, anticlockwise);
  ctx.arc(75, 75, 50, 0, 2 * Math.PI);
  ctx.strokeStyle = 'pink';
  ctx.lineWidth = 7;
  ctx.stroke();

  ctx.fillStyle = 'black';
  ctx.fill();
});
