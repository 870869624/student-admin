1. projects 表

流程：
- 项目申报：用户提交项目申请时，会在 projects 表中插入一条记录，状态设置为 declared。 
- 项目立项：管理员审核并批准项目时，更新 status 字段为 initiated。 
- 项目进行：项目进入执行阶段时，将状态更新为 progress。 
- 项目结项：项目完成时，更新 status 为 completed，并填写 actual_end_date。 
- 项目延期：项目申请延期并获得批准时，状态更新为 extended，并更新 expected_end_date。 
- 项目终止：项目因各种原因被终止时，状态更新为 terminated。

2. project_stages 表

流程：
- 记录阶段信息：每个项目的重要阶段（如申报、立项、中检、结项、延期、终止）在 project_stages 表中添加记录。 
- 阶段更新：当项目进入新的阶段（例如中期检查），在表中插入该阶段的记录并标记 status 为 progress。 
- 阶段完成：当阶段完成或获得批准时，更新该记录的 status 为 completed 或 approved。

3. project_approvals 表

流程：
- 审批记录：当项目进入需要审批的阶段时（如立项、结项、延期），在 project_approvals 表中插入一条新的审批记录，approval_status
设置为 pending。 
- 审批操作：审批人处理后，更新 approval_status 为 approved 或 rejected，并填写 comments 和 approval_date。 
- 审批跟踪：可以通过查询此表获取每个阶段的审批历史和结果。

4. project_delays 表

流程：
- 提交延期申请：项目负责人提交延期申请时，在 project_delays 表中插入一条记录，status 设置为 pending。 
- 审批延期：管理员对申请进行审批，更新 status 为 approved 或 rejected。 
- 更新项目：如果延期获得批准，更新 projects 表的 expected_end_date 和状态。

5. project_documents 表

流程：
- 文件上传：在项目的不同阶段，用户或项目成员上传文件（如报告、图片），记录插入 project_documents 表。 
- 文件关联：每个文件都关联到一个项目和具体的阶段，方便查找和管理。 
- 文件管理：用户可以通过该表查看和下载项目相关的所有文档。

整体流程说明：

	1.	项目申报：用户在 projects 表中创建项目记录。
	2.	项目审核与立项：管理员在 project_approvals 表中审核立项阶段，并更新 projects 表中的状态。
	3.	项目中检：项目在进行中时，进入中期检查阶段，在 project_stages 表中记录该阶段并更新状态。
	4.	项目延期：如果项目需要延期，提交延期申请，并在 project_delays 表中跟踪审批流程。
	5.	项目结项：项目完成时，更新 projects 表状态为 completed 并在 project_stages 表中记录结项信息。
	6.	项目终止：如果项目被终止，记录状态更新为 terminated，并在 project_stages 表中记录终止阶段。