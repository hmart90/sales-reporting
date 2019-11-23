CREATE PROCEDURE [Model].[TrainLogitModel]
	@Name AS NVARCHAR(100)
AS

DECLARE @Version INT = (SELECT ISNULL(MAX([Version]) + 1, 1) FROM Model.Model WHERE [Name] = @Name);
UPDATE Model.Model SET IsActive = 0 WHERE [Name] = @Name
DECLARE @model VARBINARY(MAX)

declare @temptable table (coef float, name nvarchar(100))
declare @modelid as int;

INSERT INTO @temptable
EXECUTE sp_execute_external_script
    @language = N'Python',
    @script = N'

import numpy
import pandas as pd
from revoscalepy import rx_logit, rx_serialize_model

stock = pd.Series(salesdata.stock, dtype=''category'')
sales = pd.Series(salesdata.sales, dtype=''float64'')
date = pd.Series(salesdata.date, dtype=''category'')
store = pd.Series(salesdata.store, dtype=''category'')
pr = pd.Series(salesdata.pr, dtype=''category'')
data = pd.DataFrame(
	{
		''stock'': stock,
		''sales'': sales,
		''date'': date,
		''pr'': pr,
		''store'': store
	}
)
regObj = rx_logit(
	"sales ~ pr + stock + date + store",
	data = data,
	cube= True
)
model = rx_serialize_model(regObj, realtime_scoring_only = False)
OutputDataSet  = regObj.coefficients
OutputDataSet[''index1''] = OutputDataSet.index',
@input_data_1 = N'SELECT pr,store,stock,sales,[date] FROM Model.ModelView;',
@input_data_1_name = N'salesdata',
@params = N'@model varbinary(max) OUTPUT',
@model = @model OUTPUT

INSERT Model.Model
    (
    [Name],
    [Version],
    [Object]
    )
 VALUES
    (
    @Name,
    @Version, 
    @model
    )

SET @modelid = SCOPE_IDENTITY()

INSERT INTO model.Coef
	
	([ModelId],
	[VariableType],
	[VariableId],
	[Coefficient])
SELECT
	@modelid,
	Substring(name, 1,Charindex('=', name)-1) as type,
	Substring(name, Charindex('=', name)+1, LEN(name)) as  id,
	coef
FROM @temptable

RETURN 0