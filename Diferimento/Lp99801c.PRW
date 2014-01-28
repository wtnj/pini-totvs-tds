#include "rwmake.ch"  
User Function LP99801C()
SetPrvt("MCTACRED")
mCtacred := ""
If TRB1->revista == "0306"
     mCtacred := '31010104005'
Elseif TRB1->revista == "0307"
     mCtacred := '31010104001'
Elseif trb1->revista == "0318"
     mCtacred := '31010104004'
Elseif TRB1->revista == "0320"
     mCtacred := '31010104003'
Elseif TRB1->revista == "0321"
     mCtacred := '31010104002'
Else
     mCtacred := '31010104006'
Endif
Return(Mctacred)