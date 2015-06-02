runtime! plugin/pangu.vim

describe 'options'
  it '設定預設選項'
    Expect g:pangu_full_ending_punct      == 1
    Expect g:pangu_full_surrounding_punct == 1
    Expect g:pangu_half_alpha             == 1
    Expect g:pangu_half_digit             == 1
    Expect g:pangu_half_non_cjk_punct     == 1
    Expect g:pangu_squeeze_cjk_punct      == 1
    Expect g:pangu_trim_spaces            == 1
  end
end

describe 'rules'
  before
    call vspec#hint({'sid': 'pangu#sid()'})
  end

  it '於正體中文環境（台灣、香港）優先使用單引號'
    for region in ['TW', 'HK']
      if empty(system(printf('locale -a | grep zh.%s.utf8', region)))
        echo printf("Test skipped: system missing support for 'zh-%s.utf8' locale.", region)
        continue
      endif

      execute printf('language ctype zh_%s.utf8', region)

      let m = Call('s:get_mappings', 'punctuations')
      Expect get(m, ']') == '」'
      Expect get(m, '>') == '〉'

      let m = vspec#call('s:get_mappings', 'punctuations_prefixed')
      Expect get(m, '[') == '「'
      Expect get(m, '<') == '〈'
    endfor
  end

  it '於簡體中文環境（中國）優先使用雙引號'
    if empty(system(printf('locale -a | grep zh.%s.utf8', 'CN')))
      SKIP "system missing support for 'zh-CN.utf8' locale."
    endif

    language ctype zh_CN.utf8

    let m = Call('s:get_mappings', 'punctuations')
    Expect get(m, ']') == '』'
    Expect get(m, '>') == '》'

    let m = vspec#call('s:get_mappings', 'punctuations_prefixed')
    Expect get(m, '[') == '『'
    Expect get(m, '<') == '《'
  end
end
