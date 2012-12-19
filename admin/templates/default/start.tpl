<div class="title">
	<h5>{#MAIN_WELCOME#}</h5>
</div>

<div class="widgets">

			{if $log_svn}
                <div class="widget">
                    <div class="head">
                        <h5>Вышла новая версия <a href="http://www.overdoze.ru/index.php?module=forums" target="_blank" class="botDir" title="{#MAIN_SVN_FORUM#}">{$smarty.const.APP_VERSION}</a>! <a href="{$svn_url}" target="_blank" class="rightDir" title="{#MAIN_SVN_REPOS#}">Рекомендуется обновиться!</a></h5>
                    </div>
                    <div style="overflow-y:auto;max-height:200px;">
                      <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
                          <tbody>
                              {foreach from=$log_svn item=revision}
                              <tr>
                                  <td><span class="webStatsLink"><a href="{$revision.url}" target="_blank" class="toprightDir" title="{#MAIN_SVN_LOOK#}">{$revision.version}</a></span></td>
                                  <td><strong><a href="mailto:{$revision.author|escape}" class="topDir" target="_blank" title="{#MAIN_SVN_MAILTO#}">{$revision.author|escape}</a></strong></td>
                                  <td style="white-space:pre-wrap">{$revision.comment|escape}</td>
                              </tr>
                              {/foreach}
                          </tbody>
                      </table>
                    </div>
                </div>
			{/if}

		<div class="widget">
			<div class="head">
				<h5>Последние документы</h5>
			</div>
			<div class="dataTables_wrapper" id="example_wrapper">
			<div class="">
			<div class="dataTables_filter" id="example_filter">
			<form method="get" id="doc_search" action="index.php">
				<input type="hidden" name="do" value="docs" />
				<input type="hidden" name="rubric_id" value="all" />
			<label>Поиск: <input type="text" placeholder="Искать документ" name="QueryTitel" style="width: 350px;"><div class="srch"></div></label>
			</form>
			</div>
			</div>
			<table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
				<col width="10" />
				<col />
				<col width="250" />
				<col width="150" />
				<col width="150" />
				<thead>
					<tr>
						<td>id</td>
						<td>Наименование</td>
						<td>Рубрика</td>
						<td>Опубликован</td>
						<td>Автор</td>
					</tr>
				</thead>
				{foreach from=$doc_start item=item}
					<tr>
						<td nowrap="nowrap"><strong><a class="toprightDir" title="{#DOC_SHOW_TITLE#}" href="../{if $item->Id!=1}index.php?id={$item->Id}&amp;cp={$sess}{/if}" target="_blank">{$item->Id}</a></strong></td>
						<td>
							<strong>
							{if $item->cantEdit==1}
								<a class="docname" href="index.php?do=docs&action=edit&rubric_id={$item->rubric_id}&Id={$item->Id}&cp={$sess}">{$item->document_title}</a>
							{else}
								{$item->document_title}
							{/if}
							</strong><br />
								<a href="../{if $item->Id!=1}{$item->document_alias}{/if}" target="_blank"><span class="dgrey doclink">{$item->document_alias}</span></a>
						</td>
						<td align="center">
							{if check_permission('rubric_edit')}
								<a href="index.php?do=rubs&action=edit&Id={$item->rubric_id}&cp={$sess}">{$item->rubric_title|escape:html}</a>
							{else}
								{$item->rubric_title|escape:html}
							{/if}
						</td>
						<td align="center"><span class="date_text dgrey">{$item->document_published|date_format:$TIME_FORMAT|pretty_date}</span></td>
						<td align="center">{$item->document_author|escape}</td>

					</tr>
				{/foreach}
			</table>
		</div>
	</div>

			<!-- Left widgets -->
            <div class="left">

                <!-- Statistics -->
                <div class="widget">
                    <div class="head">
                        <h5>{#MAIN_STAT_SYSTEM_INFO#}</h5>
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
                        <tbody>
                            <tr class="noborder">
                                <td width="50%">{#MAIN_STAT_AVE#}</td>
                                <td align="right"><span class="webStatsLink">{$smarty.const.APP_VERSION}</span></td>
                            </tr>
							<tr>
                                <td>{#MAIN_STAT_AVEREV#}</td>
                                <td align="right"><span class="webStatsLink">{$smarty.const.BILD_VERSION}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_PHP#}</td>
                                <td align="right"><span class="webStatsLink">{$php_version}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_MYSQL_VERSION#}</td>
                                <td align="right"><span class="webStatsLink">{$mysql_version}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_MYSQL#}</td>
                                <td align="right"><span class="webStatsLink">{$mysql_size}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_CACHE#}</td>
                                <td align="right"><span class="webStatsLink" id="cachesize"><a href="javascript:void(0);" id="cacheShow">Показать</a></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>

            <!-- Right widgets -->
            <div class="right">

                <!-- User widget -->
                <div class="widget">
                    <div class="head">
                        <h5>{#MAIN_STAT#}</h5>
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%" class="tableStatic">
                        <tbody>
                            <tr class="noborder">
                                <td width="50%">{#MAIN_STAT_DOCUMENTS#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.documents}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_RUBRICS#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.rubrics}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_QUERIES#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.request}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_TEMPLATES#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.templates}</span></td>
                            </tr>
                            <tr>
                                <td>{#MAIN_STAT_MODULES#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.modules_0+$cnts.modules_1}</span></td>
                            </tr>
							{if $cnts.modules_0}
                            <tr>
                                <td>{#MAIN_STAT_MODULES_OFF#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.modules_0|default:0}</span></td>
                            </tr>
							{/if}
                            <tr>
                                <td>{#MAIN_STAT_USERS#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.users_0+$cnts.users_1}</span></td>
                            </tr>
							{if $cnts.users_0}
                            <tr>
                                <td>{#MAIN_STAT_USERS_WAIT#}</td>
                                <td align="right"><span class="webStatsLink">{$cnts.users_0|default:0}</span></td>
                            </tr>
							{/if}
                        </tbody>
                    </table>
                </div>

            </div>

<div class="fix"></div>


</div>




