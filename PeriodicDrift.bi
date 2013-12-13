/**
 * Periodic drift model.
 */
model PeriodicDrift {
  const pi = 3.141592653589793;
  const h = 0.075;

  param theta;
  noise dW;
  state x, v;
  obs y;
  input ell2, sf2, epsilon; // bridge weight parameters

  sub parameter {
    theta ~ uniform(0.0, 2*pi);
  }

  sub initial {
    x <- 0;
    v <- 0;
  }

  sub transition(delta = h) {
    dW ~ wiener();
    ode(h = h, alg = 'RK4') {
      dx/dt = sin(x - theta) + dW/h;
    }
    v <- x/pi;
  }

  sub bridge {
    inline k = sf2*exp(-0.5*(t_next_obs - t_now)**2/ell2);
    inline sigma2 = sf2 - k*k/sf2 + epsilon**2;
    y ~ gaussian(x, sqrt(sigma2));
  }

  sub observation {
    y ~ gaussian(x, epsilon);
    x <- y;
  }
}
