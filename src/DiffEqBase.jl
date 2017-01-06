__precompile__()

module DiffEqBase

  using RecipesBase, SimpleTraits, RecursiveArrayTools
  using Ranges # For plot recipes with units
  import Base: length, size, getindex, endof, show, print,
               next, start, done, eltype, eachindex

  import Base: resize!

  # Problems
  "`DEProblem`: Defines differential equation problems via its internal functions"
  abstract DEProblem
  abstract DEElement
  abstract DESensitivity
  abstract AbstractODEProblem{uType,tType,isinplace,F} <: DEProblem
  abstract AbstractODETestProblem{uType,tType,isinplace,F} <: AbstractODEProblem{uType,tType,isinplace,F}
  abstract AbstractSDEProblem{uType,tType,isinplace,NoiseClass,F,F2,F3}  <: DEProblem
  abstract AbstractSDETestProblem{uType,tType,isinplace,NoiseClass,F,F2,F3}  <: AbstractSDEProblem{uType,tType,isinplace,NoiseClass,F,F2,F3}
  abstract AbstractDAEProblem{uType,duType,tType,isinplace,F} <: DEProblem
  abstract AbstractDAETestProblem{uType,duType,tType,isinplace,F} <: AbstractDAEProblem{uType,duType,tType,isinplace,F}
  abstract AbstractDDEProblem <: DEProblem

  # Algorithms
  abstract DEAlgorithm
  abstract AbstractODEAlgorithm <: DEAlgorithm
  abstract AbstractSDEAlgorithm <: DEAlgorithm
  abstract AbstractDAEAlgorithm <: DEAlgorithm

  # Options
  abstract DEOptions

  # Caches
  abstract DECache

  # Callbacks
  abstract DECallback

  # Integrators
  abstract DEIntegrator
  abstract AbstractODEIntegrator <: DEIntegrator

  # Solutions
  abstract DESolution
  abstract AbstractODESolution <: DESolution
  abstract AbstractODETestSolution <: AbstractODESolution # Needed for plot recipes
  abstract AbstractSDESolution <: AbstractODESolution # Needed for plot recipes
  abstract AbstractDAESolution <: AbstractODESolution # Needed for plot recipes
  abstract AbstractDDESolution <: AbstractODESolution # Needed for plot recipes
  abstract AbstractSensitivitySolution

  # Misc
  "`Tableau`: Holds the information for a Runge-Kutta Tableau"
  abstract Tableau
  "`ODERKTableau`: A Runge-Kutta Tableau for an ODE integrator"
  abstract ODERKTableau <: Tableau

  abstract ParameterizedFunction <: Function

  include("utils.jl")
  include("extended_functions.jl")
  include("noise_process.jl")
  include("solutions/ode_solutions.jl")
  include("solutions/sde_solutions.jl")
  include("solutions/dae_solutions.jl")
  include("solutions/solution_interface.jl")
  include("tableaus.jl")
  include("problems/ode_problems.jl")
  include("problems/sde_problems.jl")
  include("problems/dae_problems.jl")
  include("callbacks.jl")
  include("integrator_interface.jl")

  type ConvergenceSetup{P,C}
    probs::P
    convergence_axis::C
  end

  function solve end
  function solve! end
  function init end
  function step!(d::DEIntegrator) error("Integrator stepping is not implemented") end

  export DEProblem, DESolution, DEParameters, AbstractDAEProblem, AbstractDDEProblem,
         AbstractODEProblem, AbstractSDEProblem, DAESolution, DEIntegrator, Mesh,
         Tableau, DESensitivity, AbstractODESolution, ODERKTableau, ExplicitRKTableau,
         ImplicitRKTableau, AbstractSDESolution, DESensitivity, DEAlgorithm,
         AbstractODETestProblem, DECallback, DECache, DEIntegrator,AbstractODEIntegrator,
         DEOptions, AbstractODETestSolution

  export solve, solve!, init, step!

  export tuples, intervals

  export resize!,cache_iter,terminate!,add_tstop!,add_saveat!,set_abstol!,
         set_reltol!,get_du,get_dt,get_proposed_dt,modify_proposed_dt!,u_unmodified!,
         savevalues!

  export interval_tuples

  export numparameters, @def

  export HasJac, HastGrad, HasParamFuncs, HasParamDeriv, HasParamJac,
         HasInvJac,HasInvW, HasInvW_t, HasHes, HasInvHes, HasSyms

  export has_jac, has_invjac, has_invW, has_invW_t, has_hes, has_invhes,
         has_tgrad, has_paramfuncs, has_paramderiv, has_paramjac,
         has_syms

  export ODEProblem, ODETestProblem, ODESolution, ODETestSolution

  export SDEProblem, SDETestProblem, SDESolution, SDETestSolution

  export DAEProblem, DAETestProblem, DAESolution, DAETestSolution

  export build_solution, calculate_solution_errors!

  export ParameterizedFunction

  export ConvergenceSetup

  export Callback

  # Algorithms

  export AbstractODEAlgorithm, AbstractSDEAlgorithm, AbstractDAEAlgorithm

end # module
