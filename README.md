# dbt | tap-adwords

This [dbt](https://github.com/fishtown-analytics/dbt) package contains data models for [tap-adwords](https://gitlab.com/meltano/tap-adwords).

One variable is required:
* schema: the schema where the raw Google Ads tables (result of `tap-adwords`) are located

**dbt_project.yml**
```
... ...

models:
  tap_adwords:

    ... ...

    vars:
      schema:             'tap_adwords'        # the schema where the raw Google Ads tables are located
```
