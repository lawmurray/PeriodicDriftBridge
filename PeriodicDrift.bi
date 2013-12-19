/**
 * Periodic drift model.
 *
 * The model is set up for bridge sampling, where the observation block
 * provides the weighting p(x(n)|x(n-1)). The state variable mu holds the mean
 * of x(n) at each time, without the noise term w(n) having yet been
 * added. This is then used in the observation block to weight appropriately.
 */
model PeriodicDrift {
  const pi = 3.141592653589793;
  const h = 0.075;
  const theta = pi;

  noise w;
  state mu, x, v;
  obs y;
  input sigma2, epsilon; // bridge weight parameters

  sub initial {
    mu <- 0;
    x <- 0;
    v <- 0;
  }

  sub transition(delta = h) {
    mu <- x + sin(x - theta)*h;
    w ~ gaussian(0.0, sqrt(h));
    x <- (t_next_obs > 0.0 && t_now + h >= t_next_obs - 1.0e-5) ? y : mu + w;
    v <- x/pi;
  }

  sub bridge {
    inline z = round(x/pi)*pi; // centre at nearest multiple of pi
    inline delta = t_next_obs - t_now;
    inline Z = sqrt(2.0*pi*sigma2*delta)*(exp(-0.5*sigma2*delta) + 1 + epsilon);

    y ~ (cos(y - z) + 1.0 + epsilon)*exp(-0.5*(y - z)**2.0/(delta*sigma2))/Z;
  }

  sub observation {
    y ~ gaussian(mu, sqrt(h));
  }
}
