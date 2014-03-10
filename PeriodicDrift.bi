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
  input sigma2, epsilon; // bridge weight function parameters

  sub initial {
    mu <- 0;
    x <- 0;
    v <- 0;
  }

  sub transition(delta = h) {
    mu <- x + sin(x - theta)*h;
    w ~ gaussian(0.0, sqrt(h));
    x <- (t_now < t_next_obs && t_next_obs <= t_now + 1.01*h) ? y : mu + w;
    v <- x/pi; // for neater plots
  }

  sub bridge {
    const lambda = 0.25; // tempering
    inline z = round(x/(2.0*pi))*2.0*pi; // centre at nearest multiple of 2*pi
    inline delta = t_next_obs - t_now;
    inline Z = sqrt(2.0*pi*sigma2*delta)*(exp(-0.5*sigma2*delta) + 1.0 + epsilon);

    y ~ pdf(lambda*(log(cos(y - z) + 1.0 + epsilon) - 0.5*(y - z)**2.0/(delta*sigma2) - log(Z)), log = 1);
  }

  sub observation {
    y ~ gaussian(mu, sqrt(h));
  }
}
