create index dobIX 
on tblContacts(dateofbirth)

create index fullnameIX
on tblContacts(sn,fn)

drop index fullnameIX
on tblContacts