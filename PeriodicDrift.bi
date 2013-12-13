/**
 * Periodic drift model.
 */
model PeriodicDrift {
  const pi = 3.141592653589793;
  const h = 0.075;

  noise dW;
  state x;
  param theta;

  sub parameter {
    theta ~ uniform(0.0, 2*pi);
  }

  sub initial {
    x <- 0;
  }

  sub transition(delta = h) {
    dW ~ wiener();
    ode(h = h, alg = 'RK4') {
      dx/dt = sin(x - theta) + dW/h;
    }
  }  
}
