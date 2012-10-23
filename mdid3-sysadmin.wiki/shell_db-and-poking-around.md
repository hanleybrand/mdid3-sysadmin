This page isn't well explained - but it shows what information can be gleaned using the shell_plus command on your mdid3 server. 

## Starting a session

On the command line in the $ROOIBOS directory:

    $ python manage.py shell_plus

This will start a python interactive shell with many of the mdid3 specific libraries loaded. 

## Checking out records

    >>> Record.objects.all()

>```
 [<Record: r-1416356>, <Record: r-2384062>, <Record: r-9164565>, <Record: r-2439076>, <Record: r-5817437>, 
<Record: r-7123435>, <Record: r-9935313>, <Record: r-2921325>, <Record: r-1319993>, <Record: r-4109358>, 
<Record: r-9938959>, <Record: r-4575035>, <Record: r-5908705>, <Record: r-5846490>, <Record: r-3797232>, 
<Record: r-6854016>, <Record: r-3484099>, <Record: r-7268477>, <Record: r-4795782>, <Record: r-7127890>, '...
(remaining elements truncated)...']

First, create a variable that holds a single [Record](https://github.com/cit-jmu/rooibos/blob/6e3b630832d610397ff561f2dfc6c394d12400e5/rooibos/data/models.py#L99) object (if done correctly, no output will be produced):

    >>> rec = Record.objects.get(name='r-2439076')      

Then, you can begin calling methods on that - here's the base Record object minus all of the methods (see  [rooibos/data/models.py](https://github.com/cit-jmu/rooibos/blob/experimental/rooibos/data/models.py) for those) :


```python
class Record(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    modified = models.DateTimeField(auto_now=True)
    name = models.SlugField(max_length=50, unique=True)
    parent = models.ForeignKey('self', null=True, blank=True)
    source = models.CharField(max_length=1024, null=True, blank=True)
    manager = models.CharField(max_length=50, null=True, blank=True)
    next_update = models.DateTimeField(null=True, blank=True)
    owner = models.ForeignKey(User, null=True, blank=True)
```


If you check the source of an object, you can see from the code what can be gotten from it.  In the case of the rooibos Record object created by `rec = Record.objects.get(name='r-2439076')` above, the attributes can be gotten via `rec.attribute` and methods can be called like `rec.method()`: 

    >>> rec.get_absolute_url()

> '/data/record/4/r-2439076/'

    >>> rec.get_thumbnail_url()

> '/media/thumb/4/r-2439076/'

    >>> rec.get_image_url()

> '/media/get/4/r-2439076/'

    >>> rec.get_fieldvalues()

> ```[<FieldValue: IDNoneNone=A00015>, <FieldValue: TitleNoneNone=Fresco restoration, Knossos, Crete, Greece.>, ```
> ```<FieldValue: CreatorNoneNone=Unknown.>, <FieldValue: Creation YearNoneNone=ca. 1700-1300 BCE.>, ```
> ```<FieldValue: MediumNoneNone=Architecture.>, <FieldValue: CultureNoneNone=Indonesian: Java>, ```
> ```<FieldValue: PeriodNoneNone=Ancient: 3000 BCE to 4th c. CE.>, <FieldValue: StyleNoneNone=Minoan>, ```
> ```<FieldValue: CountryNoneNone=Greece>, <FieldValue: SiteNoneNone=Crete.>, ```
> ```<FieldValue: Copyright PermissionNoneNone=YES>, <FieldValue: CopyrightNoneNone=Maurie McInnis, 04/01/99.>]```

### Getting the id /pk of an object

For some other objects, you need to pass a record in, and for that you might need to pass the primary key or Record.id to select the specific record (the Record.id is the internal django pk (primary key), and has nothing to do with data you import (e.g. it wouldn't be the record's ID field)

    >>> rec.pk  

or 

    >>> rec.id  

> 4L

## Media files, and their records

Getting the rec.pk or rec.id is needed for getting the path to the image file, or information about it:

    >>> m = Media.objects.get(pk=rec.id)

    >>> m

> ```<Media: full/_img__1_12104.jpg>```

    >>> m.storage

> ```<Storage: personal-images>```

    >>> m.get_absolute_url()

> '/media/get/12006/r-7510287/4/m-1104578/'

    >>> m.get_absolute_file_path()

> u'/var/local/mdid-storage/personal/full/_img__1_12104.jpg'