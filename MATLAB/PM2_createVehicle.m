%PM2_createVehicle.m
%VEHICLE PARAMETERS SETUP SHEET TEMPLATE
vehicleName = 'PEGAS test ICBM';%by default will be used to write parameter file
%first stage
s1_m0       = 97198;            %launch mass [kg]
s1_thrust   = 1217150;          %thrust ASL [N]
s1_isp0     = 250;              %isp vacuum [s]
s1_isp1     = 230;              %isp asl [s]
s1_fm       = 75744;            %stage 1 fuel mass [kg]
s1_A        = 7.06;             %reference cross section area [m2]
s1_engT     = 1.4;              %engine ignition precedes release by [s]
dragcurve = [ 0.0   0.122;
              256.0 0.122;
              343.2 1.263;
              643.5 1.058;
              909.5 1.154;
              1673  0.776;
              9999  0.776; ];   %drag coefficient in relation to velocity [m/s -]
                                %TODO: how to deal with this? any way to get it directly from FAR plot?
s1_dm       = s1_thrust/...
                  (s1_isp1*g0); %mass flow rate [kg/s]
s1_maxT     = s1_fm*s1_isp1*g0/...
                      s1_thrust %burn time [s]
%launch site
s1_lat      = 45.9;             %latitude of the launch site [deg]
s1_lsa      = 441;              %launch site altitude [m]
%derived parameters
s1_twr      = s1_thrust/...
                     (s1_m0*g0) %TWR at launch
s1_twf      = s1_dm*s1_isp0/...
                  (s1_m0-s1_fm) %final vacuum TWR
s1_expct_dv = (s1_isp0*0.8+s1_isp1*0.2)*g0*log(s1_m0/...
                 (s1_m0-s1_fm)) %approximate expected delta-v
s1_vx_gain  = (2*pi*R/24/3600)*...
                   cosd(s1_lat) %horizontal velocity gained from Earth's rotation
%PACK (for sweep function)
global VEHICLE1;
VEHICLE1 = struct('m0', s1_m0,...
                  'dm', s1_dm,...
                  'i0', s1_isp0,...
                  'i1', s1_isp1,...
                  'mt', s1_maxT,...
                  'et', s1_engT,...
                  'ra', s1_A,...
                  'dc', dragcurve,...
                  'lat', s1_lat,...
                  'lsa', s1_lsa);
%second stage
s2_m0       = 7442;             %stage 2 mass at separation [kg]
s2_thrust   = 55400;            %thrust vacuum [N]
s2_isp      = 340;              %isp vacuum [s]
s2_fm       = 6284;             %stage 2 fuel mass [kg]
s2_dm       = s2_thrust/...
                   (s2_isp*g0); %mass flow rate [kg/s]
s2_maxT 	= s2_fm*s2_isp*g0/...
                      s2_thrust %max burn time [s]
%derived parameters
s2_twr      = s2_thrust/(s2_m0*g0)
s2_twf      = s2_dm*s2_isp/(s2_m0-s2_fm)
s2_expct_dv = s2_isp*g0*log(s2_m0/(s2_m0-s2_fm))