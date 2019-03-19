/****** Object:  StoredProcedure [asr].[sp_Filelog_Exception]    Script Date: 3/19/2019 1:56:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
Create PROCEDURE [asr].[sp_Filelog_Exception]
(
    -- Add the parameters for the stored procedure here
@Filename varchar(250),
@Exception varchar(500),
@ADFRunId int

)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	insert into asr.File_Log_Exception
	select @Filename,@Exception, @ADFRunId  

END
