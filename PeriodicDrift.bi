/**
 * Periodic drift model.
 */
model PeriodicDrift {
  const pi = 3.141592653589793;
  const h = 0.075;
  inline theta = pi;

  noise dW;
  state x, v;
  obs y;
  input sigma2, epsilon; // bridge weight parameters

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
    inline z = round(x/pi)*pi;
    inline delta = t_next_obs - t_now;
    inline Z = sqrt(2.0*pi*sigma2*delta)*(exp(-0.5*sigma2*delta) + 1 + epsilon);
    y ~ (cos(y - z) + 1.0 + epsilon)*exp(-0.5*(y - z)**2.0/(delta*sigma2))/Z;
  }

  sub observation {
    //y ~ gaussian(x, 1.0e-2);
    x <- y;
  }
}
