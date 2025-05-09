# simulate stochastic model with conformity bias
#
# parameters:
#
# N: population size
# Ninn: number of innovators at start of simulation
# alpha: advantage of G1
# beta: advantage of G2
# s: value of conformity bias
# iter: number of iterations to run simulation for
# id: an identifier added to the dataframe
# reso: only writeout every so manieth iteration
# scaletime: if TRUE; scale time by population size
#
simucon <- function(N,
                    Ninn,
                    alpha,
                    beta,
                    s,
                    iter,
                    id = 0,
                    reso = N,
                    scaletime = TRUE) {
  # this variable stores the population state: the number of G1
  # speakers
  state <- rep(0, iter+1)
  state[1] <- Ninn

  # this variable records whether the state has changed at a given
  # iteration step (we don't need to record the state when it doesn't
  # change, for display purposes)
  changed <- rep(0, iter+1)
  changed[1] <- 1

  # loop; at each iteration we pick one speaker to update
  for (t in 1:iter) {
    G1speakers <- state[t]/N
    G2speakers <- (N - state[t])/N

    birthprob <- (1-s)*G1speakers*G2speakers*alpha + s*G1speakers*G1speakers*G2speakers
    deathprob <- (1-s)*G1speakers*G2speakers*beta + s*G2speakers*G1speakers*G2speakers
    
    action <- sample(c("birth", "death", "nothing"), size=1, prob=c(birthprob, deathprob, 1 - birthprob - deathprob))
    
    if (action == "birth") {
      state[t+1] <- state[t] + 1
      if (t %% reso == 1 || t == iter) {
        changed[t+1] <- 1
      }
    } else if (action == "death") {
      state[t+1] <- state[t] - 1
      if (t %% reso == 1 || t == iter) {
        changed[t+1] <- 1
      }
    } else {
      state[t+1] <- state[t]
      if (t == iter) {
        changed[t+1] <- 1
      }
    }
  }

  # return
  if (scaletime) {
    df <- data.frame(t=(0:iter)/N, x=state/N, changed=changed)
  } else {
    df <- data.frame(t=0:iter, x=state/N, changed=changed)
  }
  df <- df[df$changed == 1, 1:2]
  df$set <- id
  df
}


# run a few simulations
#
afewsimus <- function(rep = 10,
                      N = 1000,
                      Ninn = 40,
                      alpha = 0.2,
                      beta = 0.1,
                      s = 0.1,
                      iter = 300000) {
  do.call(rbind, lapply(X=1:rep, FUN=function(X) { simucon(N=N, Ninn=Ninn, alpha=alpha, beta=beta, s=s, iter=iter, id=X, reso=10, scaletime=TRUE) }))
}
