-- CONVERT( NEW DATA TYPE, COLUMN OR EXPRESSION)
select fn + ' ' + sn +  ' (' + convert(varchar(10), contactid) + ')' as Reference, 
*  from tblcontacts

select
convert(smalldatetime, convert(varchar(4), year(getdate()))
+ '-' + convert(varchar(2),month(dateofbirth))
+ '-' + convert(varchar(2),day(dateofbirth))) as Birthday,
* from tblcontacts
 