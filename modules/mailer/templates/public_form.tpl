<section id="tabs" style="height:264px">
  <h2 class="tab_btn">{#MAILER_SUBSCRIBE#}</h2>
  <div class="tab_lay">
    {if $action=="subscribe"}
    <article>
      {$message}
    </article><br>
    {/if}
    {if !$hide_sub}
    <form method="post">
      <table class="mod_table" style="width:auto">
        <tbody>
          <tr>
            <td>{#MAILER_EMAIL#}*:</td>
            <td><input type="text" value="{$smarty.post.email|escape}" name="email" style="width:200px"></td>
          </tr>
          <tr>
            <td>{#MAILER_LNAME#}:</td>
            <td><input type="text" value="{$smarty.post.lname|escape}" name="lname" style="width:200px"></td>
          </tr>
          <tr>
            <td>{#MAILER_FNAME#}:</td>
            <td><input type="text" value="{$smarty.post.fname|escape}" name="fname" style="width:200px"></td>
          </tr>
          <tr>
            <td>{#MAILER_MNAME#}:</td>
            <td><input type="text" value="{$smarty.post.mname|escape}" name="mname" style="width:200px"></td>
          </tr>
          <tr>
            <td class="c" colspan="2"><input type="hidden" name="list_id" value="{$list_id}">
              <input type="hidden" name="action" value="subscribe">
              <input type="submit" value="{#MAILER_SUBSCRIBE#}"></td>
          </tr>
        </tbody>
      </table>
    </form>
    {/if}
  </div>
  <h2 class="tab_btn{if $action=="unsubscribe"} active{/if}">{#MAILER_UNSUBSCRIBE#}</h2>
  <div class="tab_lay">
    {if $action=="unsubscribe"}
    <article>
      {$message}
    </article><br>
    {/if}
    {if !$hide_unsub}
    <form method="post">
      <table class="mod_table" style="width:auto">
        <tbody>
          <tr>
            <td>{#MAILER_EMAIL#}*:</td>
            <td><input type="text" value="" name="email" style="width:200px"></td>
          </tr>
          <tr>
            <td class="c" colspan="2"><input type="hidden" name="list_id" value="{$list_id}">
              <input type="hidden" name="action" value="unsubscribe">
              <input type="submit" value="{#MAILER_UNSUBSCRIBE#}"></td>
          </tr>
        </tbody>
      </table>
    </form>
    {/if}
  </div>
</section>
