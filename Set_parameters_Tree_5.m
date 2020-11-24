% Defining and setting all the 65 global variables for Tree #5
%
% Tree #5 describes a network with M = 6 tiers and Q = 63 Fog nodes, used as 
% example into the User Guide.
%
%
%  ***************************************************
%  * Package: DeepFogSim                             *
%  * Author: Enzo Baccarelli and Michele Scarpiniti  *
%  * Date: September, 2020                           *
%  * Version: 4.0                                    *
%  ***************************************************
%

fprintf('..Tree #5..');

%--------------------------------------------------------------------------
% Begin the list of the global variables
global L
global cm_vec
global T_s
global M
global pertiernodes_vec
global Q
global R_MAX_vec
global V_0_vec
global V_0
global A_mtx
global epsilon_vec
global beta_vec
global L2Tmapping_vec
global T_exit_vec
global K_con_vec
global gamma_con_vec
global P_IDLE_con_vec
global P_IDLE_cla_vec
global K_cla_vec
global gamma_cla_vec
global psi_vec
global P_IDLE_NET_RX_vec
global Omega_NET_RX_vec
global Zeta_NET_RX_vec
global P_IDLE_NET_TX_vec
global Omega_NET_TX_vec
global Zeta_NET_TX_vec
global f_MAX_vec
global ftilde_MAX_vec
global I_MAX
global a_max_backup
global f_mtx
global ftilde_mtx
global R_mtx
global lambda_mtx
global iter_number
global a_max_vec_DeFogT_backup
global jump1_vec
global jump2_vec
global E_TOT_TRACK_mtx
global E_COP_TRACK_mtx
global E_NET_TRACK_mtx
global lambda1_TRACK_mtx
global lambdaM_TRACK_mtx
global E_TOT_vec
global E_COP_vec
global E_NET_vec
global E_TOT_best
global E_COP_best
global E_NET_best
global f_best_vec
global ftilde_best_vec
global R_best_vec
global perexit_delay_ratios_vec
global E_TOT_MAX
global E_COP_MAX
global E_NET_MAX
global last_iteration
global d_ECON_vs_f_mtx_aux
global d_ECLA_vs_ftilde_mtx_aux
global d_ENET_TX_vs_R_mtx_aux
global d_ENET_RX_vs_R_mtx_aux
global lambda_max
global sensitivity
global D
%End of the list of the global variables
%
%-------------------------------------------------------------------------
% fprintf('Start the current run of DeepFogSim\n');
%
%

%----Begin the setup of the 33 input variables: to be done by the user-----
L = 9; 
% Positive integer-valued number of the layers of the considered CDNN
 
cm_vec = [0.045, 0.1, 0.3, 0.5, 0.71, 0.7, 0.7, 0.9, 0.9]; %[0.025 0.1, 0.1 0.4 0.7 0.7, 0.7 0.9 0.9]; 
%(1xL) positive row vector of the per-layer compression 
% factors of the considered CDNN. 
% As a rule of thumb, 0 < cm_vec(l) < 1, if layer#l of the
% CDNN is actually equipped with a local exit, 
% while cm_vec(l) >= 1, if layer#l of the
% CDNN is NOT equipped with a local exit. 
% Lower entries correspond to lower energy consumptions
% This effect is more evident for the first entries of cm_vec
         
T_s = 1.0; % Duration of an inter-sensing period (sec)

M = 6; % Positive integer-valued number of tiers of the considered Fog 
       % platform. It must be L >= M
      
pertiernodes_vec = [32, 16, 8, 4, 2, 1]; 
% (1xM) integer-valued positive row vector of 
% the per-tier numbers of Fog nodes of the
% considered Fog platform. Its last componet must
% be 1, e.g., only a single Cloud node at tier#M

V_0_vec = ((10^6)*6/pertiernodes_vec(1))*ones(1, pertiernodes_vec(1));
%(10^6)*[1.5, 1.5, 1.5, 1.5];
% (1x pertiernodes_vec(1)) nonnegative vector of the volumes of input data
% (measured in (bit)) to be processed by the Fog nodes at tier#1 during
% each sensing interval T_s. At the current setting, V_0 must be NOT below 6 Mbit
 
A_mtx = [zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15); % Fog topology#5                                        
         zeros(1,32), ones(1,16), zeros(1,15); % Inter-topology DynDeF_RAS performance 
         zeros(1,32), ones(1,16), zeros(1,15); % comparisons
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,32), ones(1,16), zeros(1,15);
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,48), ones(1,8), zeros(1,7)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,56), ones(1,4), zeros(1,3)  ;
         zeros(1,60), ones(1,2), 0           ;
         zeros(1,60), ones(1,2), 0           ;
         zeros(1,60), ones(1,2), 0           ;
         zeros(1,60), ones(1,2), 0           ;
         zeros(1,62), 1                      ;
         zeros(1,62), 1                      ;
         zeros(1, sum(pertiernodes_vec))]    ;
% Let Q = sum(pertiernodes_vec) be the total number of Fog nodes present
% in the simulted Fog platform. Hence, A_mtx is the (QxQ) binary (e.g.,
% {0,1}-valued) matrix describing the topology of the simulated multi-tier
% hierarchical networked Fog platform. This matrix assumes that the 
% numbering of the Fog nodes is 1D and lexicographic, that is, the Fog
% nodes are progressively numbered from tier#1 to tier#M and, at ecah tier,
% from left to right. Afterwards, by design, a(i,j) == 1 
% (resp., a(i,j) == 0) if it is present (resp., it is not present) a DIRECT
% UDP/IP connection from Fog node#i to Fog node#j, 1<= i <= Q, 1 <= j <= Q.
% Since the topology of the simualted Fog platform must be HIERARCHICAL by
% design, each Fog node at tier#m may sent data only to 
% (possibly, multiple) Fog nodes at tier#(m+1), 1 <= m <= M-1. 
% This means that are not allowed connections between nodes at the same
% tier and/or at not adjacent tiers.
% The last row of the A_mtx must be the zero vector, e.g., 
% A_mtx(Q,:)=zeros(1,Q), because the Cloud node at tier#M is a sink node, 
% by design

R_MAX_vec = (((10^6)*82)/(sum(sum(A_mtx))))*ones(1, M-1);
%(10^6)*[8, 9];
% (1x(M-1)) positive row vector. R_MAX_vec(m), 1 <= m <= (M-1), is the 
% maximum transport rate (in (bit/sec)) of EACH directed UDP/IP transport
% connection going from a Fog node at tier#m to a Fog node at tier#(m+1)

epsilon_vec = (13/7)*(10^3)*ones(1, sum(pertiernodes_vec));
%(10^3)*[1 1 1 1 2 2 5]; 
% (1xQ) positive vector of the per-node processing densities (measured in
% (CPU cycles/bit)) of the CONVOLUTIONAL processors equipping the Fog
% nodes. Specifically, epsilon_vec(i), 1 <= i <= Q, is the averege number
% of CPU cycles required by the convolutional processor at Fog node#i for
% processing a bit of data when a SINGLE layer of the considered CDNN
% is supported by (e.g., mapped onto) Fog node#i. i is the 1D equivalent 
% node indexing.
 
beta_vec = (6.5/7)*(10^3)*ones(1, sum(pertiernodes_vec));
%(10^3)*[0.5 0.5 0.5 0.5 1 1 2.5];
% (1xQ) positive vector of the per-node processing densities (measured in
% (CPU cycles/bit)) of the CLASSIFIER processors equipping the Fog
% nodes. Specifically, beta_vec(i), 1 <= i <= Q, is the averege number
% of CPU cycles required by the classifier processor at Fog node#i for
% processing a bit of data, regardless from the number of CDNN layers 
% mapped onto Fog node#i. i is the 1D equivalent node indexing.
 
L2Tmapping_vec = [2, 1, 1, 2, 1, 2]; 
% The BEST is [2 1 1 2 1 2]. The sub_best is [1 2 1 2 1 2].
%[2 3 4];
% (1xM) positive integer-valued row vector. Its m-th element:
% L2Tmapping_vec(m), 1 <= m <= M, is the number of layers of the 
% considered CDNN that are mapped onto the m-th tier of the consdered 
% Fog platform. Hence, it must be: sum(L2Tmapping_vec) == L
 
T_exit_vec = [T_s*ones(1, M-1), (0.85*0.435)];%Better T_s than Inf: it is more stable
% 0.85*[0.4 0.43 0.435];
% (1xM) positive vector of the maximum delays tolerated for the generation
% of the per-tier local exits. Specifically, T_exit(m), 1 <= m <= M, is
% measured in (sec) and represents the maximum computing-plus-networking
% delay which is tolerated for the generation of a locall exit at tier#m.
% They must be: 0 < T_exit(M) <= T_s, and: 0 <= T_exit(m) < = inf, 
% 1 <= m <= (M-1). 
 
K_con_vec = (6.0)*(10^-17)*(6.5e-21)*ones(1, sum(pertiernodes_vec)); 
% (6.0)*(10^-17)*[6.5e-21, 6.5e-21, 6.5e-21, 6.5e-21, 8.5e-20, 8.5e-20, 9.0e-20]; 
% (1 x Q) positive row vector of the scaling coefficients of the dynamic
% powers consumed by the CONVOLUTIONAL processors equipping the Fog nodes. 
% Specifically, K_con_vec(i), 1 <= i < = Q, is measured in: 
% (Watt/((CPU cycles/sec)^gamma_con_vec(i))), where i is the 1D equivalent
% index for the Fog nodes
 
gamma_con_vec = 3.15*ones(1, sum(pertiernodes_vec));
% [3.2, 3.2, 3.2, 3.2, 3.1, 3.1, 3.0];
% (1 x Q) positive row vector of the exponents of the dynamic
% powers consumed by the CONVOLUTIONAL processors equipping the Fog nodes,
% where the Fog nodes are assumed to be numbered 
% according to the 1D equivalent indexing. All elements of the vector must
% be STRICTLY LARGER than 2, in order to gurantee the strict convexity of
% the resulting optimization problem
 
P_IDLE_con_vec = (10^-7)*ones(1, sum(pertiernodes_vec));
% (10^-7)*[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
% (1xQ) positive vector of the idle powers (in (Watt)) consumed by the
% convolutional processors equipping the Fog nodes, the latter numbered 
% according to the 1D equivalent indexing
 
P_IDLE_cla_vec = (10^-7)*ones(1, sum(pertiernodes_vec));
%(10^-7)*[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
% 1xQ) positive vector of the idle powers (in (Watt)) consumed by the
% classifier processors equipping the Fog nodes, the latter numbered 
% according to the 1D equivalent indexing
 
K_cla_vec = (0.1)*(10^-17)*(8.5e-20)*ones(1, sum(pertiernodes_vec));  
%(0.1)*(10^-17)*[8.5e-20, 8.5e-20, 8.5e-20, 8.5e-20, 8.5e-20, 8.5e-20, 9.0e-20];
% (1 x Q) positive row vector of the scaling coefficients of the dynamic
% powers consumed by the CLASSIFIER processors equipping the Fog nodes. 
% Specifically, K_cla_vec(i), 1 <= i < = Q, is measured in: 
% (Watt/((CPU cycles/sec)^gamma_con_vec(i))), where i is the 1D equivalent
% index for the Fog nodes
 
gamma_cla_vec = 3.0*ones(1, sum(pertiernodes_vec));
% [3.2, 3.2, 3.2, 3.2, 3.1, 3.1, 3.0];
% (1 x Q) positive row vector of the exponents of the dynamic
% powers consumed by the CLASSIFIER processors equipping the Fog nodes,
% where the Fog nodes are assumed to be numbered 
% according to the 1D equivalent indexing. All elements of the vector must
% be STRICTLY LARGER than 2, in order to guarantee the strict convexity of
% the resulting optimization problem
 
psi_vec = (1.105)*ones(1, M-1);
% (1x(M-1)) row vector of the dimensionless 
% Transport-to-Physical protocol overheads of the flows generated at tier#m, 
% 1 <= m <= M-1. Typically, 1.1 <= psi_vec(m) <= 1.2, 1 <= m <= M-1.
 
P_IDLE_NET_RX_vec = (10^-7)*[zeros(1, pertiernodes_vec(1)), ...
    0.60*ones(1, sum(pertiernodes_vec)-pertiernodes_vec(1))]; 
%(10^-7)*[zeros(1,pertiernodes_vec(1)), 0.5, 0.5, 0.7]; 
%(10^-7)*[zeros(1,pertiernodes_vec(1)), 0.60*ones(1,(sum(pertiernodes_vec)-pertiernodes_vec(1)))]; 
% (1 x Q) vector of the idle powers (measured in (Watt)) consumed by each
% receive port of a Fog node. Specifically, P_IDLE_NET_RX_vec(i),
% 1 <= i <= Q, is the idle power consumed by each receive port of Fog
% node#i, with i beng the 1D equivalent node index. Since the Fog nodes at
% tier#1 act as source node by design, the first pertiernodes_vec(1) of
% this vector are zero
 
Omega_NET_RX_vec = [zeros(1, pertiernodes_vec(1)), ...
    (45e-15)*ones(1, sum(pertiernodes_vec)-pertiernodes_vec(1))]; 
% [zeros(1,pertiernodes_vec(1)),45e-15, 45e-15,45e-15]; 
% (1 x Q) positive row vector of the scaling coefficients of the dynamic
% power consumed by each receive port equipping a Fog node, the 
% latter numbered according to the 1D equivalent indexing, e,g., 
% 1 <= i <= Q. Its i-th element is measured in: 
% (Watt/((bit/sec)^Zeta_NET_RX_vec(i))), where i is the 1D equivalent
% index for the Fog nodes. Since the Fog nodes at
% tier#1 act as source node by design, the first pertiernodes_vec(1) of
% this vector are zero
 
Zeta_NET_RX_vec = [zeros(1, pertiernodes_vec(1)), 2.15*ones(1, sum(pertiernodes_vec)-pertiernodes_vec(1))]; 
% [zeros(1,pertiernodes_vec(1)), 2.2, 2.2, 2.3]; 
% (1 x Q) row vector of the dimensionless exponents of the dynamic
% powers consumed by the receive ports equipping the Fog nodes, the 
% latter numbered according to the 1D equivalent indexing, e.g., 
% 1 <= i <= Q. Since the Fog nodes at
% tier#1 act as source node by design, the first pertiernodes_vec(1) of
% this vector are zero. All the remaining nonzero elements of this vector
% must be STRICTLY LARGER than 2, in order to guarantee the strict 
% convexity of the resulting optimization problem
 
P_IDLE_NET_TX_vec = (10^-8)*0.58*[ones(1, sum(pertiernodes_vec)-1), 0];
% (10^-8)*[0.5, 0.5, 0.5, 0.5, 0.7, 0.7, 0];
% (1 x Q) vector of the idle powers (measured in (Watt)) consumed by each
% transmit port of a Fog node. Specifically, P_IDLE_NET_TX_vec(i),
% 1 <= i <= Q, is the idle power consumed by each transmit port of Fog
% node#i, with i being the 1D equivalent node index. Since the Cloud node at
% tier#M act as a sink node by design, the last scalar Q-th entry of
% this vector must be  zero
 
Omega_NET_TX_vec = (45e-14)*[ones(1, sum(pertiernodes_vec)-1), 0];
% [9.0e-14, 9.0e-14, 9.0e-14, 9.0e-14, 45e-14, 45e-14, 0]; 
% (1 x Q) positive row vector of the scaling coefficients of the dynamic
% powers consumed by each transmit port equipping the Fog nodes, the 
% latter numbered according to the 1D equivalent indexing, e,g., 
% 1 <= i <= Q. Its i-th element is measured in: 
% (Watt/((bit/sec)^Zeta_NET_TX_vec(i))), where i is the 1D equivalent
% index for the Fog nodes. Since the Cloud node at
% tier#M acts as sink node by design, the last Q-th scalar entry of
% this vector must be zero
 
Zeta_NET_TX_vec = 2.5*[ones(1, sum(pertiernodes_vec)-1), 0];
% [2.41, 2.41, 2.41, 2.41, 2.5, 2.5, 0]; 
% (1 x Q) row vector of the dimensionless exponents of the dynamic
% powers consumed by the transmit ports equipping the Fog nodes, the 
% latter numbered according to the 1D equivalent indexing, e.g., 
% 1 <= i <= Q. Since the Cloud node at
% tier#M acts as sink node by design, the last Q-th scalar entry of
% this vector must be zero. All the remaining nonzero elements of the vector
% must be STRICTLY LARGER than 2, in order to gurantee the strict 
% convexity of the resulting optimization problem
 
f_MAX_vec = (((10^6)*63)/sum(pertiernodes_vec))*ones(1, sum(pertiernodes_vec));
% (10^6)*[9, 9, 9, 9, 9, 9, 9];%(Normal case).(10^6)*[9, 9, 9, 9, 9, 0.15, 9];%(Fault case);
% (1xQ) nonnegative vector of the maximum processing frequencies 
% (in (bit/sec)) of the CONVOLUTIONAL processors equipping the Fog nodes,
% the latter numbered according to the 1D equivalent indexing
 
ftilde_MAX_vec = (((10^6)*56)/sum(pertiernodes_vec))*ones(1, sum(pertiernodes_vec));
% (10^6)*[8, 8, 8, 8, 8, 8, 8];%(Normal case).(10^6)*[8, 8, 8, 8, 8, 0.15, 8];%(Fault case)
% (1xQ) nonnegative vector of the maximum processing frequencies 
% (in (bit/sec)) of the CLASSIFIER processors equipping the Fog nodes,
% the latter numbered according to the 1D equivalent indexing
 
I_MAX = 50;%650; 
% Positive integer-valued scalar number fixing the maximum number of 
% primal-dual iterations to be performed by each run of the DeF_RAS function
% for the evaluation of the optimized resource allocation vectors
 
a_max_backup = 5.0e-5;  
% The best a_max_backup is  5.0e-5 for the BEST Layer-to-Tier mapping:[2 1 1 2 1 2] 
% The best a_max_backup is 3.0e-5 for the SUB-best Layer-to-Tier mapping: [1 2 1 2 1 2]
% Dimensionless positive scalar parameter of the speed-factor of the
% gradient-based iterations performed by the DynDeF_RAS function. It must be
% tuned by trials, in order to balance the convergence speed-vs.-stability
% tradeoff

D = 1;
% Binary valued parameter. It is used ONLY by the DeFog_TRACKER function,
% in order to set the Continuous (e.g., D = 0) or Discontinuous (e.g., D = 1)
% version of this function.

sensitivity = 9.7; 
% The BEST sensitivity is 15.7 for the BEST layer-to-tier mapping: [2 1 1 2 1 2]
% The BEST sensitivity is 9.7 for the SUB-best layer-to-tier mapping: [1 2 1 2 1 2] 
% Dimensionless NONNEGATIVE scaling factor for the spatial-time adaptive
% setting of the a_max coefficient performed performed by both DynDeF_RAS
% and DynDeFog_TRACKER functions. By design, the setting: sensitivity = 0
% leaves a_max UNchanged and fixed to a_max_backup. 
% It corresponds to the case of STATIC a_max. Larger positive values of 
% sensitivity correspond to larger ranges of variations of a_max.
% A GOOD and ROBUST setting over the OVERALL range: 3(Mb) <= V_0 <= 9 (Mb)
% is sensitivity = 3.7 for BOTH the Discontinuous and Continuous versions of DeFog_TRACKER.

iter_number = 2000;
% Total number of primal-dual iterations performed by each run of the
% DeFog_TRACKER function. It must be integer-valued and integer mutiple by 5
 
a_max_vec_DeFogT_backup = [7.0e-6, 3.0e-6, 1.5e-6];
%(1x3) vector of the positive dimensionless speed-factors tested by each run of the DynDeFog_TRACKER function.
%Continuous Static Case 1-Top#1:[1.4e-5, 1.4e-6, 8.3e-7] is THE BEST at jump1 = jump2 = 1.0 UNDER: Topology#1,D=0, sensitivity = 0,NO warmap,V_0 = 6(Mb),iter_number = 5000 and lambda_max = 10^4;
%Discontinuous Static Case 2-Top#1:[1.85e-5, 5.0e-6, 1.85e-6] is THE BEST at:(jump1 =(6.3/6),jump2 =(5.7/6)) UNDER: Topology#1, D=1, sensitivity = 0, NO warmap,V_0 = 6(Mb),iter_number = 3000 and lambda_max=10^4;
%Discontinuous Static Case 3-Top#1:[1.0e-5, 7.5e-6, 4.0e-6] is the BEST at:(jump1 =9/6,jump2 =3/6) UNDER: Topology#1,D=1,sensitivity = 0, NO warmap,V_0 = 6(Mb),iter_number = 5000,lambda_max = 10^4;
%Discontinuous Dynamic Case 3-Top#1:[9.0e-6, 5.5e-6, 3.5e-6] is the BEST at:(jump1 =9/6,jump2 =3/6) UNDER: Topology#1, D=1, sensitivity = 3.7, NO warmap,V_0 = 6(Mb), iter_number = 2000, lambda_max = 10^4;
%Continuous Dynamic Case 3-Top#1:[2.5e-6, 1.5e-6, 9.5e-7] is the BEST at:(jump1 =9/6,jump2 =3/6) UNDER: Topology#1, D=0, sensitivity = 3.7, NO warmap,V_0 = 6(Mb), iter_number = 3500, lambda_max = 10^4; 
%Discontinuos Dynamic FAULTING Case 4-Top#2:[7.0e-6, 3.0e-6, 1.5e-6] is the BEST when Fog(1,2) faults at jump1 and Fog(2,2) faults at jump2, UNDER:
%Topology#2, D=1, sensitivity=3.7, No warmap, V_0 = 6(Mb), iter_number = 2000 and lambda_max = 10^4.
%Continuos Dynamic FAULTING Case 4-Top#2:No good results obtained. Under faulting event, the Continuos version of DeFog_TRACKER FAILS to suiitably 
%track the fault-induced variations.
%
jump1_vec =[ones(1, pertiernodes_vec(1)), 1 1 1 1 (0.15/9) 1 1, 1 1 1 1 (0.15/8) 1 1, ones(1, M-1)];%Fog node(1,2) fails
%[ones(1,pertiernodes_vec(1)), ones(1,sum(pertiernodes_vec)), ones(1,sum(pertiernodes_vec)), ones(1,M-1)];
% (1 x (pertiernodes_vec(1)+2Q+M-1)) row vector of the scalar parameters
% that specify the up/down multiplicative scaling ORDERLY applied to the scalar components
% of the input vectors: V_0_vec, f_MAX_vec, ftilde_MAX_vec and R_MAX_vec.
% The scalar entries of f_MAX_vec and ftilde_MAX_vec are assumed indexed 
% according to the 1D equivalent index. 
% This vector is utilized ONLY by the DeFog_TRACKER function.
% All scalar entries of jump1_vec must be STRICTLY positive.
% It is utilized for inducing abrupt up/down scaling changes into any 
% ordered subset of the SCALAR entries of the input resource vectors:
% V_0_vec, f_MAX_vec, ftilde_MAX_vec and R_MAX_vec.
% These changes may be induced by:
% - time-varying size of the input data to be processed during each T_s intersensing interval;
% and/or
% - failure events of the convolutional and/or classifier processors
% equipping ANY subset of Fog nodes;
% and/or
% - fading/failure events affecting ANY subset of the inter-tier UDP/IP connections.

jump2_vec = [ones(1, pertiernodes_vec(1)), 1 1 1 1 1 (0.15/9) 1, 1 1 1 1 1 (0.15/8) 1, ones(1, M-1)];%Fog node(2,2) fails
%[ones(1,pertiernodes_vec(1)), ones(1,sum(pertiernodes_vec)), ones(1,sum(pertiernodes_vec)), ones(1,M-1)];
% (1 x (pertiernodes_vec(1)+2Q+M-1)) row vector of the scalar parameters
% that specify the up/down multiplicative scaling ORDERLY applied to the scalar components
% of the input vectors: V_0_vec, f_MAX_vec, ftilde_MAX_vec and R_MAX_vec.
% The scalar entries of f_MAX_vec and ftilde_MAX_vec are assumed indexed 
% according to the 1D equivalent index. 
% This vector is utilized ONLY by the DeFog_TRACKER function.
% All scalar entries of jump2_vec must be STRICTLY positive.
% It is utilized for inducing abrupt up/down scaling changes into ANY 
% ordered subset of the SCALAR entries of the input resource vectors:
% V_0_vec, f_MAX_vec, ftilde_MAX_vec and R_MAX_vec.
% These changes may be induced by:
% - time-varying size of the input data to be processed during each T_s intersensing interval;
% and/or
% - failure events of the convolutional and/or classifier processors
% equipping any subset of Fog nodes;
% and/or
% - fading/failure events affecting any subset of the inter-tier UDP/IP connections.

lambda_max = 10^4;
% Maximum upper value allowed all Lagrange multipliers generated by DeF_RAS and
% DeFog_TRACKER. In order to guarantee stability in the steady-state, it should be
% 10^4 <= lambda_max under BOTH the Discontinuous and Continuous  versions of DeFog_TRACKER.
