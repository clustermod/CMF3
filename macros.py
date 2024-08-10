def typeLink(type):
    return f'<a href="https://community.bistudio.com/wiki/{type}">{type}</a>'

def define_env(env):
    "Macro Hook Fuction"

    @env.macro
    def FUNC(component, name):
        return f'cmf_{component}_fnc_{name}'

    @env.macro
    def FUNC_LINK(component, name, path):
        return f'[{ name } `{FUNC(component, name)}`]({ path })'
    
    @env.macro
    def FUNC_SYNTAX(parameters, component, name):
        if parameters is not None:
            return f'[{ ', '.join([f'<code>{ next(iter(paramData)) }</code>' for paramData in parameters]) }] call <b>cmf_{component}_fnc_{name}</b>'
        else:
            return f'[] call <b>cmf_{component}_fnc_{name}</b>'
    
    @env.macro
    def FUNC_PARAMS(parameters):
        if parameters is not None:
            return '</br>'.join([
                f'<b>{ next(iter(paramData)) }:</b> { typeLink(paramData[next(iter(paramData))]['type']) } - { paramData[next(iter(paramData))]['description'] } {
                    f'(Optional, default: { paramData[next(iter(paramData))]['default'] })' if 'default' in paramData[next(iter(paramData))] else ''
                }' for paramData in parameters
            ])
        else:
            return 'None'

    @env.macro
    def FUNC_EXAMPLES(examples):
        return '\n'.join([f'<tr><th>Example { i + 1 }:</th> <td markdown>\n```scilab\n{ example }\n```\n</td></tr>' for i, example in enumerate(examples)])
    
    @env.macro
    def FUNC_RETURN(returnVal):
        return f'{ f'{ typeLink(returnVal['type']) } - ' if 'type' in returnVal else '' } { returnVal['description'] }'