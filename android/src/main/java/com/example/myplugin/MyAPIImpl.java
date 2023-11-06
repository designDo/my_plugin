package com.example.myplugin;

import androidx.annotation.NonNull;

public class MyAPIImpl implements MyAPIGen.MyAPI {
    @Override
    public void sum(@NonNull Long a, @NonNull Long b, @NonNull MyAPIGen.Result<Long> result) {
        result.success(a +b);
    }
}
