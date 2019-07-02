# This file was automatically created by FeynRules 1.7.55
# Mathematica version: 8.0 for Mac OS X x86 (64-bit) (October 6, 2011)
# Date: Wed 8 Aug 2012 14:16:24



from object_library import all_parameters, Parameter


from function_library import complexconjugate, re, im, csc, sec, acsc, asec

# This is a default parameter object representing 0.
ZERO = Parameter(name = 'ZERO',
                 nature = 'internal',
                 type = 'real',
                 value = '0.0',
                 texname = '0')

MH03 = Parameter(name = 'MH03',
               nature = 'external',
               type = 'real',
               value = 455.0,
               texname = '\\text{MH03}',
               lhablock = 'MASS',
               lhacode = [ 45 ])

MT = Parameter(name = 'MT',
               nature = 'external',
               type = 'real',
               value = 172,
               texname = '\\text{MT}',
               lhablock = 'MASS',
               lhacode = [ 6 ])

MW = Parameter(name = 'MW',
               nature = 'external',
               type = 'real',
               value = 80.9387517,
               texname = '\\text{MW}',
               lhablock = 'MASS',
               lhacode = [ 24 ])

Gf = Parameter(name = 'Gf',
               nature = 'external',
               type = 'real',
               value = 0.0000116637,
               texname = 'G_f',
               lhablock = 'SMINPUTS',
               lhacode = [ 2 ])


MZ = Parameter(name = 'MZ',
               nature = 'external',
               type = 'real',
               value = 91.1876,
               texname = '\\text{MZ}',
               lhablock = 'MASS',
               lhacode = [ 23 ])

aEWM1 = Parameter(name = 'aEWM1',
                  nature = 'external',
                  type = 'real',
                  value = 132.50698,
                  texname = '\\text{aEWM1}',
                  lhablock = 'SMINPUTS',
                  lhacode = [ 1 ])

aEW = Parameter(name = 'aEW',
                nature = 'internal',
                type = 'real',
                value = '1/aEWM1',
                texname = '\\text{aEW}')


ee = Parameter(name = 'ee',
               nature = 'internal',
               type = 'real',
               value = '2*cmath.sqrt(aEW)*cmath.sqrt(cmath.pi)',
               texname = 'e')

sw2 = Parameter(name = 'sw2',
                nature = 'internal',
                type = 'real',
                value = '1 - MW**2/MZ**2',
                texname = '\\text{sw2}')

sw = Parameter(name = 'sw',
               nature = 'internal',
               type = 'real',
               value = 'cmath.sqrt(sw2)',
               texname = 's_w')

v = Parameter(name = 'v',
              nature = 'internal',
              type = 'real',
              value = '(2*MW*sw)/ee',
              texname = 'v')

aS = Parameter(name = 'aS',
               nature = 'external',
               type = 'real',
               value = 0.118,
               texname = '\\text{aS}',
               lhablock = 'SMINPUTS',
               lhacode = [ 3 ])

G = Parameter(name = 'G',
              nature = 'internal',
              type = 'real',
              value = '2*cmath.sqrt(aS)*cmath.sqrt(cmath.pi)',
              texname = 'G')

GH = Parameter(name = 'GH',
               nature = 'internal',
               type = 'real',
               value = '-(G**2*(1 + (13*MH03**6)/(16800.*MT**6) + MH03**4/(168.*MT**4) + (7*MH03**2)/(120.*MT**2)))/(12.*cmath.pi**2*v)',
               texname = 'G_H')





WH03 = Parameter(name = 'WH03',
               nature = 'external',
               type = 'real',
               value = 1.0,
               texname = '\\text{WH}',
               lhablock = 'DECAY',
               lhacode = [ 45 ])

WH1 = Parameter(name = 'WH1',
                nature = 'external',
                type = 'real',
                value = 0.00575308848,
                texname = '\\text{WH1}',
                lhablock = 'DECAY',
                lhacode = [ 9000006 ])

MP = Parameter(name = 'MP',
               nature = 'external',
               type = 'real',
               value = 120,
               texname = '\\text{MP}',
               lhablock = 'MASS',
               lhacode = [ 9000006 ])

Gphi = Parameter(name = 'Gphi',
                 nature = 'internal',
                 type = 'real',
                 value = '-(G**2*(1 + MH03**6/(560.*MT**6) + MH03**4/(90.*MT**4) + MH03**2/(12.*MT**2)))/(8.*cmath.pi**2*v)',
                 texname = 'G_h')

AH = Parameter(name = 'AH',
               nature = 'internal',
               type = 'real',
               value = '(47*ee**2*(1 - (2*MH03**4)/(987.*MT**4) - (14*MH03**2)/(705.*MT**2) + (213*MH03**12)/(2.634632e7*MW**12) + (5*MH03**10)/(119756.*MW**10) + (41*MH03**8)/(180950.*MW**8) + (87*MH03**6)/(65800.*MW**6) + (57*MH03**4)/(6580.*MW**4) + (33*MH03**2)/(470.*MW**2)))/(72.*cmath.pi**2*v)',
               texname = 'A_H')
