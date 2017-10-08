---------------------------------------
-- Generated by SIMECT
-- Generated on: 06-May-2011 13:25:51
---------------------------------------

LIBRARY IEEE;
USE IEEE.electrical_systems.all;
use IEEE.math_real.all;
USE work.all;

ENTITY test_i_uni_v_diff IS

  PORT    (TERMINAL Vin,Vout1,Vout2: ELECTRICAL);

END ENTITY test_i_uni_v_diff;

ARCHITECTURE behavioral OF test_i_uni_v_diff IS

  CONSTANT Out_1_Num_TF_dir1_1 : REAL_VECTOR := (1.000000000000e+00, 0.0);
  CONSTANT Out_1_Den_TF_dir1_1 : REAL_VECTOR := (4.470028399999e-03, 5.733292492384e-13, 3.408664392785e-23, 0.0);
  CONSTANT Out_1_Num_TF_dir2_1 : REAL_VECTOR := (-1.000000000000e+00, 2.445868599598e-11, 0.0);
  CONSTANT Out_1_Den_TF_dir2_1 : REAL_VECTOR := (4.460686230453e-03, 5.568423204870e-13, 2.576161552007e-23, 0.0);
  CONSTANT Out_1_Num_TF_inv1_1 : REAL_VECTOR := (-9.892880797907e-05, 3.338012087606e-14, -1.425943495954e-26, 0.0);
  CONSTANT Out_1_Den_TF_inv1_1 : REAL_VECTOR := (1.000000000000e+00, 6.195859370473e-12, 5.453311620995e-23, 0.0);
  CONSTANT Out_1_Num_TF_inv2_1 : REAL_VECTOR := (-3.773617656493e-05, 4.419346963619e-15, 1.692955418853e-27, 0.0);
  CONSTANT Out_1_Den_TF_inv2_1 : REAL_VECTOR := (1.000000000000e+00, 3.281525489475e-12, 1.019975349910e-23, 0.0);
  CONSTANT Out_1_Num_Zin1_1 : REAL_VECTOR := (1.000000000000e+00, 6.678426423279e-11, 0.0);
  CONSTANT Out_1_Den_Zin1_1 : REAL_VECTOR := (9.391444779809e-02, 1.477278420010e-12, 1.148428505854e-26, 0.0);
  CONSTANT Out_1_Num_Zout1_1 : REAL_VECTOR := (4.273775005404e-01, 9.548858738211e-10, 1.677978259085e-22, 0.0);
  CONSTANT Out_1_Den_Zout1_1 : REAL_VECTOR := (1.000000000000e+00, 8.204132513609e-12, 3.352364881738e-23, 0.0);
  CONSTANT Out_1_Num_Zout2_1 : REAL_VECTOR := (5.555912699692e-01, 9.508601005656e-10, 1.578279126858e-22, 0.0);
  CONSTANT Out_1_Den_Zout2_1 : REAL_VECTOR := (1.000000000000e+00, 8.179687280301e-12, 3.307060100070e-23, 0.0);
  CONSTANT Out_1_Num_Zout_diff1_1 : REAL_VECTOR := (1.000000000000e+00, 5.820412762870e-12, 0.0);
  CONSTANT Out_1_Den_Zout_diff1_1 : REAL_VECTOR := (6.484134373146e-08, 4.898083009242e-19, 0.0);
  CONSTANT Out_1_Num_Zout_diff2_1 : REAL_VECTOR := (1.000000000000e+00, 6.025324293750e-12, 0.0);
  CONSTANT Out_1_Den_Zout_diff2_1 : REAL_VECTOR := (1.047326426864e-07, 4.981381359743e-19, 0.0);
  CONSTANT Out_1_OffIn11 : REAL := -1.000000e-04;
  CONSTANT Out_1_OffIn12 : REAL := 2.139866e+00;
  CONSTANT Out_1_OffOut11 : REAL := 7.486680e-01;
  CONSTANT Out_1_OffOut12 : REAL := -3.200000e-15;
  CONSTANT Out_1_OffOut21 : REAL := 6.889038e-01;
  CONSTANT Out_1_OffOut22 : REAL := 3.200000e-15;
  QUANTITY Vin1 ACROSS Iin1 THROUGH Vin TO ground; 
  QUANTITY Vout1_1 ACROSS Iout1_1 THROUGH Vout1 TO ground; 
  QUANTITY Vout2_1 ACROSS Iout2_1 THROUGH Vout2 TO ground; 
  QUANTITY deltaIin1: current;
  QUANTITY deltaIout1_1, deltaIout2_1: current;

BEGIN

  deltaIin1 == Iin1 - Out_1_OffIn11;
  deltaIout1_1 == Iout1_1 - Out_1_OffOut12;
  deltaIout2_1 == Iout2_1 - Out_1_OffOut22;
  Vout1_1 == deltaIin1'LTF(Out_1_Num_TF_dir1_1,Out_1_Den_TF_dir1_1)+ deltaIout1_1'LTF(Out_1_Num_Zout1_1,Out_1_Den_Zout1_1)+ deltaIout2_1'LTF(Out_1_Num_Zout_diff2_1,Out_1_Den_Zout_diff2_1)+ Out_1_OffOut11;
  Vout2_1 == deltaIin1'LTF(Out_1_Num_TF_dir2_1,Out_1_Den_TF_dir2_1)+ deltaIout2_1'LTF(Out_1_Num_Zout2_1,Out_1_Den_Zout2_1)+ deltaIout1_1'LTF(Out_1_Num_Zout_diff1_1,Out_1_Den_Zout_diff1_1)+ Out_1_OffOut21;
  Vin1 == deltaIin1'LTF(Out_1_Num_Zin1_1,Out_1_Den_Zin1_1)+ deltaIout1_1'LTF(Out_1_Num_TF_inv1_1,Out_1_Den_TF_inv1_1)+ deltaIout2_1'LTF(Out_1_Num_TF_inv2_1,Out_1_Den_TF_inv2_1)+ Out_1_OffIn12;

END ARCHITECTURE behavioral;
