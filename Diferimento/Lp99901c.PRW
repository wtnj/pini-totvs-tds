#include "rwmake.ch"  
User Function LP99901C()
SetPrvt("MCTACRED")
mCtacred := ""
If TRB1->revista $"0107"
     mCtacred := '31010101001'
Elseif TRB1->revista $"0115/0101/0102/0103/0104/0105/0114"
     mCtacred := '31010103001'
Elseif TRB1->revista $"0116"
     mCtacred := '31010102001'
Else
     mCtacred := '31010101003'
Endif
Return(Mctacred)