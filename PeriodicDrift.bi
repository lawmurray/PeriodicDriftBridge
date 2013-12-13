/**
 * Periodic drift model.
 */
model PeriodicDrift {
  noise dW;
  state x;
  const pi = 3.141592653589793;
  param theta;

  sub parameter {
    theta ~ uniform(0.0, 2*pi);
  }

  sub initial {
    x <- 0;
  }

  sub transition {
    dW ~ wiener();
    ode {
      dx/dt = sin(x - theta) + dW;
    }
  }
  
}
