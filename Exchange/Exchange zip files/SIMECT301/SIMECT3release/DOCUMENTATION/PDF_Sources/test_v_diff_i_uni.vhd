---------------------------------------
-- Generated by SIMECT
-- Generated on: 06-May-2011 13:16:24
---------------------------------------

LIBRARY IEEE;
USE IEEE.electrical_systems.all;
use IEEE.math_real.all;
USE work.all;

ENTITY test_v_diff_i_uni IS

  PORT    (TERMINAL Vin1,Vin2,Vout: ELECTRICAL);

END ENTITY test_v_diff_i_uni;

ARCHITECTURE behavioral OF test_v_diff_i_uni IS

  CONSTANT Out_1_Num_TF_dir1_1 : REAL_VECTOR := (-6.382952406239e-04, -1.865209132334e-14, -2.891627924441e-27, 0.0);
  CONSTANT Out_1_Den_TF_dir1_1 : REAL_VECTOR := (1.000000000000e+00, 9.621419314472e-11, 3.132313392602e-24, 0.0);
  CONSTANT Out_1_Num_TF_dir3_1 : REAL_VECTOR := (6.435489035437e-04, 9.567718906029e-14, -3.975971644185e-25, 0.0);
  CONSTANT Out_1_Den_TF_dir3_1 : REAL_VECTOR := (1.000000000000e+00, 2.365869386389e-10, 9.819312614588e-24, 0.0);
  CONSTANT Out_1_Num_TF_inv1_1 : REAL_VECTOR := (-4.184695656605e-08, -5.120591493976e-17, 0.0);
  CONSTANT Out_1_Den_TF_inv1_1 : REAL_VECTOR := (1.000000000000e+00, 8.692232169418e-14, 3.818216810059e-27, 0.0);
  CONSTANT Out_1_Num_TF_inv3_1 : REAL_VECTOR := (2.599411535755e-09, -1.707786240565e-15, -6.703670200199e-26, 0.0);
  CONSTANT Out_1_Den_TF_inv3_1 : REAL_VECTOR := (1.000000000000e+00, 4.054694846162e-11, 1.646642971882e-24, 0.0);
  CONSTANT Out_1_Num_Zin1_1 : REAL_VECTOR := (1.000000000000e+00, 2.893318669891e-14, 2.450059585818e-41, 0.0);
  CONSTANT Out_1_Den_Zin1_1 : REAL_VECTOR := (1.242578255775e-05, 1.421833685887e-14, 0.0);
  CONSTANT Out_1_Num_Zin2_1 : REAL_VECTOR := (1.000000000000e+00, 2.887872311313e-14, 0.0);
  CONSTANT Out_1_Den_Zin2_1 : REAL_VECTOR := (8.131049334413e-06, 1.429005155715e-14, 0.0);
  CONSTANT Out_1_Num_Zin_diff1_1 : REAL_VECTOR := (1.000000000000e+00, 3.682570219954e-11, 4.732351155263e-24, 0.0);
  CONSTANT Out_1_Den_Zin_diff1_1 : REAL_VECTOR := (1.666008446512e-08, -6.617738601393e-15, -1.563189171752e-25, 0.0);
  CONSTANT Out_1_Num_Zin_diff2_1 : REAL_VECTOR := (1.000000000000e+00, 3.682570219954e-11, 4.732351155263e-24, 0.0);
  CONSTANT Out_1_Den_Zin_diff2_1 : REAL_VECTOR := (1.666008446512e-08, -6.617738601393e-15, -1.563189171752e-25, 0.0);
  CONSTANT Out_1_Num_Zout1_1 : REAL_VECTOR := (1.000000000000e+00, 1.537288179971e-13, 4.697232927446e-27, 0.0);
  CONSTANT Out_1_Den_Zout1_1 : REAL_VECTOR := (1.977611066977e-05, 2.390770157746e-14, 1.713603321547e-27, 0.0);
  CONSTANT Out_1_OffIn11 : REAL := 1.000000e+00;
  CONSTANT Out_1_OffIn12 : REAL := 0.000000e+00;
  CONSTANT Out_1_OffIn21 : REAL := 1.000000e+00;
  CONSTANT Out_1_OffIn22 : REAL := 0.000000e+00;
  CONSTANT Out_1_OffOut11 : REAL := 1.455432e-06;
  CONSTANT Out_1_OffOut12 : REAL := 2.000000e+00;
  QUANTITY Vin1 ACROSS Iin1 THROUGH Vin1 TO ground; 
  QUANTITY Vin2 ACROSS Iin2 THROUGH Vin2 TO ground; 
  QUANTITY Vout1_1 ACROSS Iout1_1 THROUGH Vout TO ground; 
  QUANTITY deltaVin1, deltaVin2: voltage;
  QUANTITY deltaVout1_1: voltage;

BEGIN

  deltaVin1 == Vin1 - Out_1_OffIn11;
  deltaVin2 == Vin2 - Out_1_OffIn21;
  deltaVout1_1 == Vout1_1 - Out_1_OffOut12;
  Iout1_1 == deltaVin1'LTF(Out_1_Num_TF_dir1_1,Out_1_Den_TF_dir1_1)+ deltaVin2'LTF(Out_1_Num_TF_dir3_1,Out_1_Den_TF_dir3_1)+ deltaVout1_1'LTF(Out_1_Den_Zout1_1,Out_1_Num_Zout1_1)+ Out_1_OffOut11;
  Iin1 == deltaVin1'LTF(Out_1_Den_Zin1_1,Out_1_Num_Zin1_1)+ deltaVin2'LTF(Out_1_Den_Zin_diff2_1,Out_1_Num_Zin_diff2_1)+ deltaVout1_1'LTF(Out_1_Num_TF_inv1_1,Out_1_Den_TF_inv1_1)+ Out_1_OffIn12;
  Iin2 == deltaVin2'LTF(Out_1_Den_Zin2_1,Out_1_Num_Zin2_1)+ deltaVin1'LTF(Out_1_Den_Zin_diff1_1,Out_1_Num_Zin_diff1_1)+ deltaVout1_1'LTF(Out_1_Num_TF_inv3_1,Out_1_Den_TF_inv3_1)+ Out_1_OffIn22;

END ARCHITECTURE behavioral;

