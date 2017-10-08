/*
 * strcmpC.c
 * 
 * This function takes two MATLAB string as an argument, 
 * copies them in NULL terminated ANSI C string and compares
 * them using strcmp from C string library. 
 *
 * This source code heavily uses mxmalloc.c from the examples.
 * Type edit([matlabroot '/extern/examples/mx/mxmalloc.c']); at 
 * MATLAB prompt to see this file.
 *
 */

#include <string.h>
#include "mex.h"
   
void mexFunction(int nlhs,mxArray *plhs[],
                    int nrhs,const mxArray *prhs[])
{
    char *str1, *str2;
    mwSize buflen;
    int status;
    double *result;
    
    /* Check for proper number of input and output arguments */
    if (nrhs != 2) 
    { 
        mexErrMsgTxt("Two input argument required.");
    } 
    if (nlhs > 1) 
    {
        mexErrMsgTxt("Too many output arguments.");
    }
    
    /* Check for proper input type */
    if (!mxIsChar(prhs[0]) || (mxGetM(prhs[0]) != 1 ) ||
        !mxIsChar(prhs[1]) || (mxGetM(prhs[1]) != 1 ) )  
    {
        mexErrMsgTxt("Input arguments must be strings.");
    }
        
    /* Copy the string data into buf. */ 
    buflen = mxGetN(prhs[0])*sizeof(mxChar) + 1;
    str1 = mxMalloc(buflen);
    status = mxGetString(prhs[0], str1, buflen);
    
    buflen = mxGetN(prhs[1])*sizeof(mxChar) + 1;
    str2 = mxMalloc(buflen);    
    status = mxGetString(prhs[1], str2, buflen);  
    
    /* Create a matrix for the output argument */ 
    plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
    result = mxGetPr(plhs[0]);
    *result = strcmp(str1,str2);
    
    /* free memory */
    mxFree(str1);
    mxFree(str2);    
} /*end mexFunction*/