### Alphabetical list of collections

```
SELECT 
    data_collection.id,
    data_collection.title,
    data_collection.name,
    data_collection.owner_id,
    data_collection.hidden,
    data_collection.description,
    data_collection.agreement,
FROM
    data_collection
ORDER BY data_collection.title ASC
```
### Getting the database id of a specific user by username

```
SELECT id, username
FROM `rooibos`.`auth_user`
WHERE auth_user.username = 'llux'
```

### How many presentations does that user have?

```
SELECT 
    COUNT(presentation_presentation.id)
FROM
    presentation_presentation
WHERE
    presentation_presentation.owner_id = 60
```

### getting information about records

```
SELECT 
    id, created, modified, name, owner_id
FROM
    data_record
WHERE
    data_record.id = 41588 
```

This gets some information about a record, but it's not all of the metadata, here's the output:

<table>  
<tr>
<td>id</td>
<td>created</td>
<td>modified/td>
<td>name</td>
<td>owner_id</td>
</tr>
<tr>
<td>41588</td>
<td>2007-10-04 13:32:23<td>
2010-10-20 09:15:58</td>
<td>r-6165371</td>
<td>60</td>
</tr>
</table>

If you want detailed information, maybe it's unsurprising that some JOINs are necessary:

```
SELECT 
    data_record.id,
    data_record.name,
    data_fieldvalue.label,
    data_fieldvalue.value
FROM
    rooibos.data_record
        INNER JOIN
    rooibos.data_fieldvalue ON data_fieldvalue.record_id = data_record.id
WHERE
    data_record.id = 41588
```

<table>
 <col>
 <col>
 <col>
 <col>
 <tr>
  <td>41588</td>

  <td>r-6165371</td>
  <td>Date</td>
  <td>1964</td>
 </tr>
 <tr>
  <td>41588</td>
  <td>r-6165371</td>

  <td>Description</td>
  <td>mixed material assemblage</td>
 </tr>
 <tr>
  <td>41588</td>
  <td>r-6165371</td>
  <td>Creator</td>

  <td>Kienholz, Edward</td>
 </tr>
 <tr>
  <td>41588</td>
  <td>r-6165371</td>
  <td>Title</td>
  <td>Back Seat Dodge, '38</td>

 </tr>


</table>
